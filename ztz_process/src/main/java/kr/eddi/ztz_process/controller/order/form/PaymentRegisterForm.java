package kr.eddi.ztz_process.controller.order.form;

import kr.eddi.ztz_process.service.order.request.PaymentRegisterRequest;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
@NoArgsConstructor
public class PaymentRegisterForm {

    private Integer paymentPrice;
    private String merchant_uid;

    private OrderInfoRegisterForm sendInfo;
    private String imp_uid;
    private String city;
    private String street;
    private String addressDetail;
    private String zipcode;
    private String sendRequest;
    public PaymentRegisterRequest toOrderRegisterRequest () {
        return new PaymentRegisterRequest( paymentPrice, merchant_uid, sendInfo , imp_uid ,city ,street ,addressDetail , zipcode, sendRequest);
    }
}
