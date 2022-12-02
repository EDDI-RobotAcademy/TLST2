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

    public MemberRegisterRequest toMemberRegisterRequest () {
        return new MemberRegisterRequest( email, password, username, birthdate);
    }
}
