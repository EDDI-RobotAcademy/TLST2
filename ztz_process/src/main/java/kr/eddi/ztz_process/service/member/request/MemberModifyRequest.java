package kr.eddi.ztz_process.service.member.request;

import lombok.Data;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Data
@Getter
@ToString
@RequiredArgsConstructor
public class MemberModifyRequest {
    private final String password;
    private final String manager_code;
    private final String new_password;
//    private final String new_password_confirm; ※vue쪽에서 확인하면 되는 상황이라 process에서는 따로 필요없다.
    private final String phoneNumber;
    private final Long id;
}
