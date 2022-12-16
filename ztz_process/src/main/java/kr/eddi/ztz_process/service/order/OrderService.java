package kr.eddi.ztz_process.service.order;

import kr.eddi.ztz_process.service.order.request.CancelRequest;
import kr.eddi.ztz_process.service.order.request.ModifyRequest;
import kr.eddi.ztz_process.service.order.request.PaymentRegisterRequest;

import java.util.List;

public interface OrderService {

    public Boolean registerOrderInfo(PaymentRegisterRequest paymentRegisterRequest);

    public Boolean CancelAllOrder(CancelRequest cancelRequest);

    public Boolean ModifyOrder(List<ModifyRequest> modifyRequest);

}
