package kr.eddi.ztz_process.service.order;

import com.siot.IamportRestClient.exception.IamportResponseException;
import kr.eddi.ztz_process.controller.order.form.OrderForm;
import kr.eddi.ztz_process.controller.order.request.RefundRequest;
import kr.eddi.ztz_process.controller.order.request.ChangeOrderStateRequest;
import kr.eddi.ztz_process.entity.order.OrderInfo;
import kr.eddi.ztz_process.entity.order.Payment;
import kr.eddi.ztz_process.service.order.request.PaymentRegisterRequest;

import java.io.IOException;
import java.util.List;

public interface OrderService {

    public Boolean registerOrderInfo(PaymentRegisterRequest paymentRegisterRequest);

    public Boolean refundAllOrder(RefundRequest refundRequest) throws IamportResponseException, IOException;

    public List<OrderInfo> readAllOrders(Long PaymentId);

    public OrderInfo readOrder(Long orderId);
    public List<Payment> readAllPayment(String token);

    public List<Payment> readRangePaymentList(String token , String rangeData);

    public List<Payment> readManagerAllPayment();

    public List<OrderInfo> changeOrderState(ChangeOrderStateRequest changeOrderStateRequest);

    public Integer salesAmount();

    public Boolean registerOrderInfo(OrderForm orderForm);
    Payment savePayment(OrderForm orderForm);

    public List<OrderInfo> reviewWritableList(String token);

}
