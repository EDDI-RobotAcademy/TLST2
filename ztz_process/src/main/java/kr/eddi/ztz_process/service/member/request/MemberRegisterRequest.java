package kr.eddi.ztz_process.service.member.request;

import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.entity.member.MemberProfile;
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

    private final String city;
    private final String street;
    private final String addressDetail;
    private final String zipcode;
    private final String phoneNumber;

    public Member toMember () {
        return new Member(
                email,
                username,
                birthdate,
                MemberProfile.of(city, street, addressDetail, zipcode,phoneNumber)
        );
    }
}
