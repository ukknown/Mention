package com.ssafy.mention.jwt;

import com.ssafy.mention.domain.Member;
import com.ssafy.mention.exception.member.MemberExceptionEnum;
import com.ssafy.mention.exception.member.MemberRuntimeException;
import com.ssafy.mention.repository.MemberRepository;
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
        Member member = memberRepository.findByEmail(email)
                .orElseThrow(() -> new MemberRuntimeException(MemberExceptionEnum.MEMBER_NOT_EXIST_EXCEPTION));
        log.info("email in loadUserByUsername = " + member.getEmail());

        return new CustomUserDetails(member);
    }
}