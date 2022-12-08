package kr.eddi.ztz_process.service.member;

import kr.eddi.ztz_process.entity.member.Authentication;
import kr.eddi.ztz_process.entity.member.BasicAuthentication;
import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.repository.member.AuthenticationRepository;
import kr.eddi.ztz_process.repository.member.MemberRepository;
import kr.eddi.ztz_process.service.member.request.MemberLoginRequest;
import kr.eddi.ztz_process.service.member.request.MemberRegisterRequest;
import kr.eddi.ztz_process.service.security.RedisService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private AuthenticationRepository authenticationRepository;

    @Autowired
    private RedisService redisService;


    @Override
    public Boolean emailValidation(String email) {
        Optional<Member> maybeMember = memberRepository.findByEmail(email);
        if (maybeMember.isPresent()) {
            return false;
        }
        return true;
    }

    @Override
    public Boolean signUp(MemberRegisterRequest request) {
        final Member member = request.toMember();
        memberRepository.save(member);

        final BasicAuthentication auth = new BasicAuthentication(member,
                Authentication.BASIC_AUTH, request.getPassword());

        authenticationRepository.save(auth);

        return true;
    }

    @Override
    public String signIn(MemberLoginRequest request) {
        String email = request.getEmail();
        Optional<Member> maybeMember = memberRepository.findByEmail(email);

        if (maybeMember.isPresent()) {
            Member member = maybeMember.get();

            log.info("member email: " + member.getEmail());
            log.info("request email: " + request.getEmail());
            log.info("request password: " + request.getPassword());

            if (!member.isRightPassword(request.getPassword())) {
                // 패스워드가 잘못 된 경우
                throw new RuntimeException("아이디 또는 패스워드가 잘못되었습니다");
            }

            UUID userToken = UUID.randomUUID();

            redisService.deleteByKey(userToken.toString());
            redisService.setKeyAndValue(userToken.toString(), member.getId());

            log.info("유저토큰: "+userToken.toString());
            log.info("레디스 유저토큰으로 멤버아이디 구하기: "+ redisService.getValueByKey(userToken.toString()));
            log.info("유저토큰:"+userToken.toString() +" 멤버아이디:"+ member.getId());

            return userToken.toString();
        }

        // 이메일이 가입되어 있지 않은 경우
        throw new RuntimeException("아이디 또는 패스워드가 잘못되었습니다");
    }

    @Override
    public void withdrawal(String token) {
        Long id = redisService.getValueByKey(token);
        Member member = memberRepository.findByMemberId(id);
        memberRepository.delete(member);
    }

    @Override
    public Member returnMemberInfo(String token) {
        Long id = redisService.getValueByKey(token);
        Member member = memberRepository.findByMemberId(id);
        return member;
    }

}
