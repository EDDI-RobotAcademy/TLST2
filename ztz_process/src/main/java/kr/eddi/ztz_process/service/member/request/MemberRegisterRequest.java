package kr.eddi.ztz_process.service.member.request;

import kr.eddi.ztz_process.entity.member.Member;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@RequiredArgsConstructor
public class MemberRegisterRequest {

    private final String email;
    private final String password;

    private final String username;
    private final int birthdate;

    public Member toMember () {
        return new Member(
                email,
                username,
                birthdate
        );
    }
}
