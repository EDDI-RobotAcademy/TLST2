package kr.eddi.ztz_process.service.member.request;

import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.entity.member.MemberProfile;
import lombok.Data;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Data
@Getter
@ToString
@RequiredArgsConstructor
public class MemberAddressRequest {
    private final String city;
    private final String street;
    private final String addressDetail;
    private final String zipcode;
    private final String token;

}
