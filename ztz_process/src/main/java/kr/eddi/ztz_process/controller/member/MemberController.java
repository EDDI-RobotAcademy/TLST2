package kr.eddi.ztz_process.controller.member;

import kr.eddi.ztz_process.controller.member.form.MemberAddressForm;
import kr.eddi.ztz_process.controller.member.form.MemberLoggedInTokenForm;
import kr.eddi.ztz_process.controller.member.form.MemberLoginForm;
import kr.eddi.ztz_process.controller.member.form.MemberRegisterForm;
import kr.eddi.ztz_process.entity.member.ManagerCode;
import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.entity.member.MemberProfile;
import kr.eddi.ztz_process.repository.member.ManagerCodeRepository;
import kr.eddi.ztz_process.repository.member.MemberRepository;
import kr.eddi.ztz_process.service.member.MemberService;
import kr.eddi.ztz_process.service.member.request.MemberModifyRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;


@Slf4j
@RestController
@RequestMapping("ztz/member")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class MemberController {

    @Autowired
    private MemberService service;

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private ManagerCodeRepository managerCodeRepository;

    @PostMapping("/check-email/{email}")
    public Boolean emailValidation(@PathVariable("email") String email) {
        log.info("emailValidation(): " + email);

        return service.emailValidation(email);
    }

    @PostMapping("/check-manager/{managerCode}")
    public Boolean managerCodeValidation(@PathVariable("managerCode") String managerCode) {
        log.info("managerCodeValidation(): " + managerCode);

        return service.managerCodeValidation(managerCode);
    }

    @PostMapping("/sign-up")
    public Boolean signUp(@RequestBody MemberRegisterForm form) {
        log.info("signUp: " + form);
        log.info("매니저코드: "+ form.getManagerCode());
        if(form.getManagerCode()== null ||form.getManagerCode().isEmpty()){
            return service.signUp(form.toMemberRegisterRequest());
        }else{
            return service.signUp(form.toManagerRegisterRequest());
        }


    }

    @PostMapping("/sign-in")
    public String signIn(@RequestBody MemberLoginForm form) {
        log.info("signIn: " + form);
        return service.signIn(form.toLoginRequest());
    }

    @DeleteMapping(path = "/withdrawal", headers = "Token")
    public void withdrawal(@RequestHeader("Token") String token) {
        String SubString = "";
        if(token.length() >= 37){
            SubString = token.substring(1,37);
        }else {
            SubString = token;
        }
        service.withdrawal(SubString);
    }

    @PostMapping("/user-verification")
    public Member userVerification(@RequestBody MemberLoggedInTokenForm memberLoggedInTokenForm) {
        String SubString = "";
        if(memberLoggedInTokenForm.getToken().length() >= 37){
            SubString = memberLoggedInTokenForm.getToken().substring(1,37);
        }else {
            SubString = memberLoggedInTokenForm.getToken();
        }
        Member member = service.returnMemberInfo(SubString);
        log.info(member.getEmail());
        return member;
    }

    @PostMapping("/user-profile")
    public MemberProfile userProfile(@RequestBody MemberLoggedInTokenForm memberLoggedInTokenForm) {
        String SubString = "";
        if(memberLoggedInTokenForm.getToken().length() >= 37){
            SubString = memberLoggedInTokenForm.getToken().substring(1,37);
        }else {
            SubString = memberLoggedInTokenForm.getToken();
        }
        MemberProfile memberProfile = service.returnMemberProfile(SubString);
        log.info(memberProfile.getId().toString());
        log.info(memberProfile.getMember().toString());
        log.info(memberProfile.getPhoneNumber().toString());
        log.info(memberProfile.getAddress().toString());
        return memberProfile;
    }

    @PostMapping("/modify-address")
    public Boolean modifyAddress(@RequestBody MemberAddressForm memberAddressForm){
        log.info("modifyAddress" + memberAddressForm);


        return service.ModifyMemberAddress(memberAddressForm.toMemberAddressRequest());
    }

    @PostMapping("/modify-profile")
    public String modifyProfile(@RequestBody MemberModifyRequest memberModifyRequest){
        String msg = "";
        ManagerCode managerCode;
        Member member = memberRepository.findByMemberId(memberModifyRequest.getId());
        log.info("관리자 코드: " + memberModifyRequest.getManager_code());
        log.info("멤버 ID 확인" + memberModifyRequest.getId());
        log.info("비밀번호 확인" + memberModifyRequest.getPassword());
        log.info("새 비밀번호 확인" + memberModifyRequest.getNew_password());
        Optional<ManagerCode> maybeManagerCode = managerCodeRepository.findByCode(memberModifyRequest.getManager_code());
        if (memberModifyRequest.getManager_code() == null || memberModifyRequest.getManager_code().isEmpty()) {
            if (!member.isRightPassword(memberModifyRequest.getPassword())) { // password가 아니면
                return msg = "기존 비밀번호가 맞지 않아 회원정보 변경이 실패하였습니다.";
            } else {
                return service.ModifyMemberProfile(memberModifyRequest); // vue쪽에서 받은 ModifyRequest 정보를 받아
            }
        }
        else {
            if (!member.isRightPassword(memberModifyRequest.getPassword())) { // password가 아니면
                return msg = "기존 비밀번호가 맞지 않아 회원정보 변경이 실패하였습니다.";
            } else if (!maybeManagerCode.isPresent()) {
                return msg = "관리자 코드가 맞지 않아 회원정보 변경이 실패하였습니다.";
            } else if (!maybeManagerCode.isPresent() && !member.isRightPassword(memberModifyRequest.getPassword())) {
                return msg = "기존 비밀번호와 관리자 코드가 맞지 않아 회원정보 변경이 실패하였습니다."; // vue쪽에서 받은 ModifyRequest 정보를 받아옴
            } else {
                return service.ModifyMemberProfile(memberModifyRequest); // vue쪽에서 받은 ModifyRequest 정보를 받아
            }
        }
    }

    @PostMapping("/manager-profile")
    public String managerProfile(@RequestBody MemberLoggedInTokenForm memberLoggedInTokenForm) {
        String SubString = "";
        if (memberLoggedInTokenForm.getToken().length() >= 37){
            SubString = memberLoggedInTokenForm.getToken().substring(1,37);
        } else {
            SubString = memberLoggedInTokenForm.getToken();
        }

        return service.returnManagerProfile(SubString);
    }
}
