package kr.eddi.ztz_process.service.order.request;

import kr.eddi.ztz_process.controller.order.form.OrderInfoRegisterForm;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.ToString;
@Data
@ToString
@RequiredArgsConstructor
public class PaymentRegisterRequest {
    private final Integer paymentPrice;
    private final String merchant_uid;
    private final OrderInfoRegisterForm sendInfo;

    private final String imp_uid;
    private final String city;
    private final String street;
    private final String addressDetail;
    private final String zipcode;
    private final String sendRequest;
}
