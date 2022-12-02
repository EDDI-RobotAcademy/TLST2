package kr.eddi.ztz_process.controller.member.form;

import kr.eddi.ztz_process.service.member.request.MemberLoginRequest;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class MemberLoginForm {

    private String email;
    private String password;

    public MemberLoginRequest toLoginRequest () {
        return new MemberLoginRequest(email, password);
    }
}
