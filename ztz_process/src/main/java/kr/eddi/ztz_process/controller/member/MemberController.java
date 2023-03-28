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
        return service.emailValidation(email);
    }

    @PostMapping("/check-manager/{managerCode}")
    public Boolean managerCodeValidation(@PathVariable("managerCode") String managerCode) {
        return service.managerCodeValidation(managerCode);
    }

    @PostMapping("/sign-up")
    public Boolean signUp(@RequestBody MemberRegisterForm form) {
        if(form.getManagerCode()== null ||form.getManagerCode().isEmpty()){
            return service.signUp(form.toMemberRegisterRequest());
        }else{
            return service.signUp(form.toManagerRegisterRequest());
        }


    }

    @PostMapping("/sign-in")
    public String signIn(@RequestBody MemberLoginForm form) {
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
        return memberProfile;
    }

    @PostMapping("/modify-address")
    public Boolean modifyAddress(@RequestBody MemberAddressForm memberAddressForm){
        return service.ModifyMemberAddress(memberAddressForm.toMemberAddressRequest());
    }

    @PostMapping("/modify-profile")
    public String modifyProfile(@RequestBody MemberModifyRequest memberModifyRequest){
        String msg = "";
        ManagerCode managerCode;
        Member member = memberRepository.findByMemberId(memberModifyRequest.getId());

        Optional<ManagerCode> maybeManagerCode = managerCodeRepository.findByCode(memberModifyRequest.getManager_code());

        if(!memberModifyRequest.isManagerCheck()){
            if (!member.isRightPassword(memberModifyRequest.getPassword())) {
                return msg = "기존 비밀번호가 맞지 않아 회원정보 변경이 실패하였습니다.";
            } else {
                return service.ModifyMemberProfile(memberModifyRequest);
            }
        }
        else {
            if(memberModifyRequest.getManager_code() == null || memberModifyRequest.getManager_code().isEmpty() || memberModifyRequest.getManager_code()== "undefined") {
                return msg = "관리자코드를 입력해주세요";
            }  else if (!member.isRightPassword(memberModifyRequest.getPassword())) {
                return msg = "기존 비밀번호가 맞지 않아 회원정보 변경이 실패하였습니다.";
            } else if (!maybeManagerCode.isPresent()) {
                return msg = "관리자 코드가 맞지 않아 회원정보 변경이 실패하였습니다.";
            } else if (!maybeManagerCode.isPresent() && !member.isRightPassword(memberModifyRequest.getPassword())) {
                return msg = "기존 비밀번호와 관리자 코드가 맞지 않아 회원정보 변경이 실패하였습니다.";
            } else {
                return service.ModifyMemberProfile(memberModifyRequest);
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
