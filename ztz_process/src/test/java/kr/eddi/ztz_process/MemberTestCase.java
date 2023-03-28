package kr.eddi.ztz_process;

import kr.eddi.ztz_process.entity.member.AuthorityType;
import kr.eddi.ztz_process.entity.member.ManagerCode;
import kr.eddi.ztz_process.repository.member.ManagerCodeRepository;
import kr.eddi.ztz_process.service.member.MemberService;
import kr.eddi.ztz_process.service.member.request.MemberLoginRequest;
import kr.eddi.ztz_process.service.member.request.MemberModifyRequest;
import kr.eddi.ztz_process.service.member.request.MemberRegisterRequest;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class MemberTestCase {

    @Autowired
    private MemberService service;
    @Autowired
    private ManagerCodeRepository managerCodeRepository;

    @Test
    void managerCodeTest() {
        ManagerCode managerCode1 = new ManagerCode("ztz2022");
        ManagerCode managerCode2 = new ManagerCode("ztz2023");
        managerCodeRepository.save(managerCode1);
        managerCodeRepository.save(managerCode2);
    }

    @Test
    void memberSignUpTest() {
        MemberRegisterRequest registerRequest = new MemberRegisterRequest(
                "meme@me.com", "meme", "김미미", 19931106, AuthorityType.MEMBER, false,"ztz2022",
                "서울특별시","중랑구","면목동","어딘가","010-0000-0000");
        service.signUp(registerRequest);
    }

    @Test
    void managerSignUpTest() {
        MemberRegisterRequest registerRequest = new MemberRegisterRequest(
                "manager@manager.com", "manager", "박관리", 19931106, AuthorityType.MANAGER,true,
                "010-0000-0000");
        service.signUp(registerRequest);
    }

    @Test
    void memberSignInTest() {
        MemberLoginRequest loginRequest = new MemberLoginRequest("he@he.com", "hehe");
        service.signIn(loginRequest);
    }

    @Test
    void emailValidationTest(){
        boolean emailCheck = service.emailValidation("he@he.com");
        System.out.println("이메일 중복 체크: " + emailCheck);
    }

    @Test
    void memberModifyTest() {
        MemberModifyRequest memberModifyRequest = new MemberModifyRequest(true, "abc", "ztz2022", "1234", "010-1234-4321", 1L);
        service.ModifyMemberProfile(memberModifyRequest);
    }
}