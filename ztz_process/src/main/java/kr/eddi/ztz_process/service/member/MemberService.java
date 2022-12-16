package kr.eddi.ztz_process.service.member;

import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.entity.member.MemberProfile;
import kr.eddi.ztz_process.service.member.request.MemberAddressRequest;
import kr.eddi.ztz_process.service.member.request.MemberLoginRequest;
import kr.eddi.ztz_process.service.member.request.MemberRegisterRequest;


public interface MemberService {
    Boolean signUp(MemberRegisterRequest request);
    Boolean emailValidation(String email);
    String signIn(MemberLoginRequest request);
    void withdrawal(String token);
    Member returnMemberInfo(String token);

    MemberProfile returnMemberProfile(String token);

    Boolean ModifyMemberAddress(MemberAddressRequest memberAddressRequest);
}
