package kr.eddi.ztz_process;

import kr.eddi.ztz_process.service.member.MemberService;
import kr.eddi.ztz_process.service.member.request.MemberLoginRequest;
import kr.eddi.ztz_process.service.member.request.MemberRegisterRequest;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class MemberTestCase {

    @Autowired
    private MemberService service;

    @Test
    void memberSignUpTest() {
        MemberRegisterRequest registerRequest = new MemberRegisterRequest("he1@he.com", "hehe", "김헤헤", 19931106);
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

}





