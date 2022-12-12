package kr.eddi.ztz_process.controller.member;

import kr.eddi.ztz_process.controller.member.form.MemberLoggedInTokenForm;
import kr.eddi.ztz_process.controller.member.form.MemberLoginForm;
import kr.eddi.ztz_process.controller.member.form.MemberRegisterForm;
import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.entity.member.MemberProfile;
import kr.eddi.ztz_process.service.member.MemberService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


@Slf4j
@RestController
@RequestMapping("ztz/member")
@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")
public class MemberController {

    @Autowired
    private MemberService service;

    @PostMapping("/check-email/{email}")
    public Boolean emailValidation(@PathVariable("email") String email) {
        log.info("emailValidation(): " + email);

        return service.emailValidation(email);
    }

    @PostMapping("/sign-up")
    public Boolean signUp(@RequestBody MemberRegisterForm form) {
        log.info("signUp: " + form);

        return service.signUp(form.toMemberRegisterRequest());
    }

    @PostMapping("/sign-in")
    public String signIn(@RequestBody MemberLoginForm form) {
        log.info("signIn: " + form);

        return service.signIn(form.toLoginRequest());
    }

    @DeleteMapping(path = "/withdrawal", headers = "Token")
    public void withdrawal(@RequestHeader("Token") String token) {
        String SubString = token.substring(1,37);
        service.withdrawal(SubString);
    }

    @PostMapping("/user-verification")
    public Member userVerification(@RequestBody MemberLoggedInTokenForm memberLoggedInTokenForm) {
        String SubString = memberLoggedInTokenForm.getToken().substring(1,37);
        Member member = service.returnMemberInfo(SubString);
        log.info(member.getEmail());
        return member;
    }

    @PostMapping("/user-profile")
    public MemberProfile userProfile(@RequestBody MemberLoggedInTokenForm memberLoggedInTokenForm) {
        String SubString = memberLoggedInTokenForm.getToken().substring(1,37);
        MemberProfile memberProfile = service.returnMemberProfile(SubString);
        log.info(memberProfile.getId().toString());
        log.info(memberProfile.getMember().toString());
        log.info(memberProfile.getPhoneNumber().toString());
        log.info(memberProfile.getAddress().toString());
        return memberProfile;
    }

}
