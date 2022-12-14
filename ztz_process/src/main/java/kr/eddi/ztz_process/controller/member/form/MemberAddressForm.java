package kr.eddi.ztz_process.controller.member.form;

import kr.eddi.ztz_process.service.member.request.MemberAddressRequest;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class MemberAddressForm {

    private String city;
    private String street;
    private String addressDetail;
    private String zipcode;
    private String token;

    public MemberAddressRequest toMemberAddressRequest(){
        return new MemberAddressRequest(city,street,addressDetail,zipcode,token);
    }
}
