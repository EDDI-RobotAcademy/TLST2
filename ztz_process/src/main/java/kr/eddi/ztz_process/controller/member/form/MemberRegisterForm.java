package kr.eddi.ztz_process.controller.member.form;

import kr.eddi.ztz_process.service.member.request.MemberRegisterRequest;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class MemberRegisterForm {

    private String email;
    private String password;
    private String username;
    private int birthdate;

    private Long authorityNo;
    private String authorityName;

    private boolean managerCheck;
    private String managerCode;
    private String city;
    private String street;
    private String addressDetail;
    private String zipcode;
    private String phoneNumber;
    public MemberRegisterRequest toMemberRegisterRequest () {
        return new MemberRegisterRequest( email, password, username, birthdate, authorityNo, authorityName,managerCheck, city,street,addressDetail,zipcode, phoneNumber);
    }

    public MemberRegisterRequest toManagerRegisterRequest() {
        return new MemberRegisterRequest( email, password, username, birthdate, authorityNo, authorityName,managerCheck, phoneNumber);
    }
}
