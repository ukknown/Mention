package com.ssafy.memberservice.service;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.ssafy.memberservice.exception.auth.AuthExceptionEnum;
import com.ssafy.memberservice.exception.auth.AuthRuntimeException;
import com.ssafy.memberservice.exception.member.MemberExceptionEnum;
import com.ssafy.memberservice.exception.member.MemberRuntimeException;
import com.ssafy.memberservice.jpa.MemberEntity;
import com.ssafy.memberservice.jpa.MemberRepository;
import com.ssafy.memberservice.jwt.JwtTokenProvider;
import com.ssafy.memberservice.vo.Role;
import com.ssafy.memberservice.vo.dto.common.KakaoTokenResponse;
import com.ssafy.memberservice.vo.dto.common.KakaoUserInfoResponse;
import com.ssafy.memberservice.vo.dto.response.TokenResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{

    private final MemberRepository memberRepository;
    private final JwtTokenProvider jwtTokenProvider;
    private final StringRedisTemplate stringRedisTemplate;

    @Value("${kakao.client-id}")
    private String API_KEY;

    @Value("${jwt.secret}")
    private String secret_key;

    @Value("${kakao.redirect-uri}")
    private String REDIRECT_URI;


    private String tokenReqURL = "https://kauth.kakao.com/oauth/token";

    private String userReqUrl = "https://kapi.kakao.com/v2/user/me";

    @Override
    @Transactional
    public ResponseEntity<TokenResponse> joinOrLogin(String code) {
        //카카오 인증 api에서 인증 토큰을 받아옴
        KakaoTokenResponse kakaoTokenResponse = getKakaoToken(code);
        //인증 토큰으로부터 카카오 사용자 정보를 받아옴
        KakaoUserInfoResponse kakaoUserInfoResponse = getKakaoUser(kakaoTokenResponse.getAccessToken());

        String email = "";
        //받아옴 email 정보를 이용해 해당 이메일로 가입된 회원 있는지 조회
        MemberEntity joinMember = memberRepository.findByEmail(kakaoUserInfoResponse.getEmail()).orElse(null);


        if (joinMember == null) {//회원이 없다면
            //회원정보 DB 저장
            MemberEntity member = MemberEntity
                    .builder()
                    .email(kakaoUserInfoResponse.getEmail())
                    .nickname(kakaoUserInfoResponse.getNickname())
                    .role(Role.ROLE_USER)
                    .build();
            email = kakaoUserInfoResponse.getEmail();
            memberRepository.saveAndFlush(member);
        } else {
            email = joinMember.getEmail();
        }

        //jwt 토큰 생성
//        TokenResponse tokenResponse = jwtTokenProvider.createToken(email);
        TokenResponse tokenResponse = jwtTokenProvider.createToken(email);

        return new ResponseEntity<>(tokenResponse, HttpStatus.OK);
    }

    @Override
    public KakaoTokenResponse getKakaoToken(String code) {

        try {
            URL url = new URL(tokenReqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=" + API_KEY);
            sb.append("&redirect_uri=" + REDIRECT_URI);
            sb.append("&code=" + code);
            bw.write(sb.toString());
            bw.flush();

            //결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            log.info("토큰 가져올 때 responseCode : " + responseCode);

            //요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }

            br.close();
            bw.close();

            //Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            return KakaoTokenResponse.builder()
                    .accessToken(element.getAsJsonObject().get("access_token").getAsString())
                    .refreshToken(element.getAsJsonObject().get("refresh_token").getAsString())
                    .build();

        } catch (IOException e) {
            throw new AuthRuntimeException(AuthExceptionEnum.AUTH_KAKAO_ACCESSTOKEN_FAILED);
        }
    }

    @Override
    public KakaoUserInfoResponse getKakaoUser(String accessToken) {
        String email = "";
        try {
            URL url = new URL(userReqUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setRequestProperty("Authorization", "Bearer " + accessToken); //전송할 header 작성, access_token전송

            //결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            log.info("유저 정보 가져올 때 responseCode : " + responseCode);

            //요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            log.info("response body : " + result);

            //Gson 라이브러리로 JSON파싱
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            long id = element.getAsJsonObject().get("id").getAsLong();
            String nickname = element.getAsJsonObject().get("properties").getAsJsonObject().get("nickname").getAsString();
            boolean hasEmail = element.getAsJsonObject().get("kakao_account").getAsJsonObject().get("has_email").getAsBoolean();
            if (hasEmail) {
                email = element.getAsJsonObject().get("kakao_account").getAsJsonObject().get("email").getAsString();
            } else {
                throw new MemberRuntimeException(MemberExceptionEnum.MEMBER_KAKAO_EMAIL_EXCEPTION);
            }

            br.close();
            return KakaoUserInfoResponse.builder()
                    .id(id)
                    .email(email)
                    .nickname(nickname)
                    .build();
        } catch (IOException e) {
            throw new AuthRuntimeException(AuthExceptionEnum.AUTH_KAKAO_ACCESSTOKEN_FAILED);
        }
    }

    @Override
    @Transactional
    public ResponseEntity<TokenResponse> refresh(String refreshToken, String email) {
        String solvedToken;
        if (refreshToken != null && refreshToken.startsWith("Bearer ")) {
            solvedToken = refreshToken.substring(7);
        } else {
            solvedToken = null;
        }
        String redisToken = stringRedisTemplate.opsForValue().get(email);
        System.out.println(redisToken);
        if (jwtTokenProvider.validateToken(solvedToken) && solvedToken.equals(stringRedisTemplate.opsForValue().get(email))) {
            return new ResponseEntity<>(jwtTokenProvider.createToken(email), HttpStatus.OK);
        } else {
            throw new AuthRuntimeException(AuthExceptionEnum.AUTH_REFRESH_EXCEPTION);
        }

    }

}
