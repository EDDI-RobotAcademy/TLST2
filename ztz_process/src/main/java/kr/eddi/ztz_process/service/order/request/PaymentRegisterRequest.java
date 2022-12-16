package kr.eddi.ztz_process.service.order.request;

import kr.eddi.ztz_process.controller.order.form.OrderInfoRegisterForm;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

import java.util.List;

@Data
@ToString
@RequiredArgsConstructor
public class PaymentRegisterRequest {
    private final Integer paymentPrice;
    private final String merchant_uid;
    private final OrderInfoRegisterForm sendInfo;
}
