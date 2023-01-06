package kr.eddi.ztz_process.service.member;

import jakarta.persistence.Basic;
import kr.eddi.ztz_process.entity.member.*;
import kr.eddi.ztz_process.repository.member.*;
import kr.eddi.ztz_process.service.member.request.MemberAddressRequest;
import kr.eddi.ztz_process.service.member.request.MemberLoginRequest;
//import kr.eddi.ztz_process.service.member.request.MemberModifyRequest;
import kr.eddi.ztz_process.service.member.request.MemberModifyRequest;
import kr.eddi.ztz_process.service.member.request.MemberRegisterRequest;
import kr.eddi.ztz_process.service.security.RedisService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
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
    private BasicAuthenticationRepository basicAuthenticationRepository;

    @Autowired
    private ManagerCodeRepository managerCodeRepository;


    @Autowired
    private RedisService redisService;

    @Autowired
    private MemberProfileRepository memberProfileRepository;

    @Autowired
    private AuthorityRepository authorityRepository;

    @Override
    public Boolean emailValidation(String email) {
        Optional<Member> maybeMember = memberRepository.findByEmail(email);
        if (maybeMember.isPresent()) {
            return false;
        }
        return true;
    }

    @Override
    public Boolean managerCodeValidation(String managerCode) {
        Optional<ManagerCode> maybeManager = managerCodeRepository.findByCode(managerCode);
        if (maybeManager.isPresent()) {
            return true;
        }
        return false;
    }

    @Override
    public Boolean signUp(MemberRegisterRequest request) {
        log.info("매니저코드: " + request.getManagerCode());
        if (request.getManagerCode() == null || request.getManagerCode().isEmpty()) {
            log.info("일반회원 가입");
            final Member member = request.toMember();
            memberRepository.save(member);

            final BasicAuthentication auth = new BasicAuthentication(member,
                    Authentication.BASIC_AUTH, request.getPassword());

            authenticationRepository.save(auth);

        } else {
            log.info("관리자회원 가입");
            final Member member = request.toManager();
            memberRepository.save(member);

            final BasicAuthentication auth = new BasicAuthentication(member,
                    Authentication.BASIC_AUTH, request.getPassword());

            authenticationRepository.save(auth);
        }

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

            log.info("유저토큰: " + userToken.toString());
            log.info("레디스 유저토큰으로 멤버아이디 구하기: " + redisService.getValueByKey(userToken.toString()));
            log.info("유저토큰:" + userToken.toString() + " 멤버아이디:" + member.getId());
            return userToken.toString();
        }

        // 이메일이 가입되어 있지 않은 경우
        throw new RuntimeException("아이디 또는 패스워드가 잘못되었습니다");
    }

    @Override
    public void withdrawal(String token) {
        Long id = redisService.getValueByKey(token);
        Member member = memberRepository.findByMemberId(id);

        authorityRepository.delete(member.getAuthority());
        memberRepository.delete(member);
    }

    @Override
    public Member returnMemberInfo(String token) {
        Long id = redisService.getValueByKey(token);
        Member member = memberRepository.findByMemberId(id);

        return member;
    }

    @Override
    public MemberProfile returnMemberProfile(String token) {
        Long id = redisService.getValueByKey(token);
        Member member = memberRepository.findByMemberId(id);

        MemberProfile memberProfile = memberProfileRepository.findProfileByMemberId(member.getId());
        return memberProfile;
    }

    @Override
    public Boolean ModifyMemberAddress(MemberAddressRequest memberAddressRequest) {
        try {
            Long id = redisService.getValueByKey(memberAddressRequest.getToken().substring(1, 37));
            Member member = memberRepository.findByMemberId(id);
            MemberProfile memberProfile = memberProfileRepository.findProfileByMemberId(member.getId());

            Address address = Address.of(
                    memberAddressRequest.getCity(),
                    memberAddressRequest.getStreet(),
                    memberAddressRequest.getAddressDetail(),
                    memberAddressRequest.getZipcode());
            memberProfile.modifyAddress(address);

            memberProfileRepository.save(memberProfile);
            return true;

        } catch (Exception e) {
            System.out.println(e);

            return false;
        }
    }

    @Override
    public String ModifyMemberProfile(MemberModifyRequest memberModifyRequest) {
        String msg = "";

        try {
            Member member = memberRepository.findByMemberId(memberModifyRequest.getId());
            MemberProfile memberProfile = memberProfileRepository.findProfileByMemberId(member.getId());

            log.info("관리자 코드: " + memberModifyRequest.getManager_code());
            Optional<Authentication> authentication = authenticationRepository.findByMemberId(memberModifyRequest.getId());
            log.info("new password check" + memberModifyRequest.getNew_password());
                log.info("회원정보 변경");
                if ((memberModifyRequest.getNew_password() == null || memberModifyRequest.getNew_password().isEmpty()) && (memberModifyRequest.getPhoneNumber() != null || !memberModifyRequest.getPhoneNumber().isEmpty())) { // 핸드폰번호만 수정!
                    memberProfile.modifyPhoneNumber(memberModifyRequest.getPhoneNumber());
                    memberProfileRepository.save(memberProfile);
                } else if ((memberModifyRequest.getNew_password() != null || !memberModifyRequest.getNew_password().isEmpty()) && (memberModifyRequest.getPhoneNumber() == null || memberModifyRequest.getPhoneNumber().isEmpty())) { // 비밀번호만 수정!
                    Optional<BasicAuthentication> maybeBasicAuthentication = basicAuthenticationRepository.findByMemberID(memberModifyRequest.getId());
                    BasicAuthentication basicAuthentication = maybeBasicAuthentication.get();
                    basicAuthentication.setPassword(memberModifyRequest.getNew_password());
                    basicAuthenticationRepository.save(basicAuthentication);
                } else {
                    memberProfile.modifyPhoneNumber(memberModifyRequest.getPhoneNumber());
                    memberProfileRepository.save(memberProfile);
                    Optional<BasicAuthentication> maybeBasicAuthentication = basicAuthenticationRepository.findByMemberID(memberModifyRequest.getId());
                    BasicAuthentication basicAuthentication = maybeBasicAuthentication.get();
                    basicAuthentication.setPassword(memberModifyRequest.getNew_password());
                    basicAuthenticationRepository.save(basicAuthentication);
                }

                return msg = "회원정보 변경이 성공되었습니다.";

        } catch (Exception e) {
            System.out.println(e);

            return msg = "회원정보 변경이 실패되었습니다. 다시 시도해주세요.";
        }
    }

    @Override
    public String returnManagerProfile(String token) {
        Long id = redisService.getValueByKey(token); // 회원번호를 반환해서 그 값을 id로 담는다!
        Member member = memberRepository.findByMemberId(id); // 멤버정보를 MemberId값으로 찾으면서 Member 클래스를 데이터 타입으로 가져온다.

        MemberProfile memberProfile = memberProfileRepository.findProfileByMemberId(member.getId()); // 멤버 프로필 정보 조회
        System.out.println("관리자 번호는 : " + memberProfile.getPhoneNumber());
        return memberProfile.getPhoneNumber();
    }
}
