package com.ssafy.memberservice.jwt;


import com.ssafy.memberservice.exception.member.MemberExceptionEnum;
import com.ssafy.memberservice.exception.member.MemberRuntimeException;
import com.ssafy.memberservice.jpa.MemberEntity;
import com.ssafy.memberservice.jpa.MemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserDetailsServiceImpl implements UserDetailsService {

    private final MemberRepository memberRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        MemberEntity memberEntity = memberRepository.findByEmail(email)
                .orElseThrow(() -> new MemberRuntimeException(MemberExceptionEnum.MEMBER_NOT_EXIST_EXCEPTION));
        log.info("email in loadUserByUsername = " + memberEntity.getEmail());

        return new CustomUserDetails(memberEntity);
    }
}