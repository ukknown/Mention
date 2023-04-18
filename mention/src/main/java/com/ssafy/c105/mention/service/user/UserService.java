package com.ssafy.c105.mention.service.user;

import com.ssafy.c105.mention.dto.jwt.SignInResultDto;
import com.ssafy.c105.mention.entity.user.User;
import com.ssafy.c105.mention.repository.UserRepository;
import com.ssafy.c105.mention.security.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = false)
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    private final JwtTokenProvider jwtTokenProvider;
    public SignInResultDto Signin(String username, String email) {
        boolean existedUser = userRepository.existsByEmail(email);

        if(!existedUser){
            SignInResultDto notExistedUser = new SignInResultDto();
            notExistedUser.setMsg("존재하지않는 이름");
            notExistedUser.setCode(401);
            notExistedUser.setSuccess(false);
            return notExistedUser;
        }

        User user = userRepository.findByEmail(email);

        SignInResultDto signInResultDto = SignInResultDto.builder()
                .username(username)
                .email(email)
                .token(jwtTokenProvider.createToken(String.valueOf(user.getEmail()))).build();

        return signInResultDto;

    }

    public void signUp(String username, String email) {
        User user = userRepository.save(User.builder()
                .username(username)
                .email(email)
                .build()
        );
    }
}
