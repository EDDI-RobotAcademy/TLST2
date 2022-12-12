package kr.eddi.ztz_process.controller.order.form;

import kr.eddi.ztz_process.service.order.request.PaymentRegisterRequest;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.List;
import java.util.Map;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class PaymentRegisterForm {

    private Integer TotalPaymentPrice;
    private String merchant_uid;

    private List<OrderInfoRegisterForm> orderInfos;


    public PaymentRegisterRequest toOrderRegisterRequest () {
        return new PaymentRegisterRequest( TotalPaymentPrice, merchant_uid, orderInfos);
    }
}
