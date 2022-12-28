package kr.eddi.ztz_process.controller.order;

import com.siot.IamportRestClient.exception.IamportResponseException;
import kr.eddi.ztz_process.controller.member.form.MemberLoggedInTokenForm;
import kr.eddi.ztz_process.controller.order.form.PaymentRegisterForm;
import kr.eddi.ztz_process.controller.order.request.RefundRequest;
import kr.eddi.ztz_process.controller.order.request.ChangeOrderStateRequest;
import kr.eddi.ztz_process.entity.order.OrderInfo;
import kr.eddi.ztz_process.entity.order.Payment;
import kr.eddi.ztz_process.entity.products.Product;
import kr.eddi.ztz_process.service.order.OrderService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("ztz/order")
@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")
public class OrderController {


    @Autowired
    private OrderService service;

    @PostMapping("/OrderRegister")
    public Boolean orderRegister(@RequestBody PaymentRegisterForm paymentRegisterForm){
        log.info("orderRegister" + paymentRegisterForm);

        return service.registerOrderInfo(paymentRegisterForm.toOrderRegisterRequest());
    }

    // 주문관리 - 상세보기
    @PostMapping("/ReadAllOrder/{paymentId}")
    public List<OrderInfo> ReadAllOrder(@PathVariable("paymentId") Long paymentId){
        log.info("ReadAllOrder" + paymentId);

        List<OrderInfo> orderInfoList = service.readAllOrders(paymentId);
        System.out.println(orderInfoList.get(0).getOrderID());
        return orderInfoList;
    }
    //주문관리 리스트
    @PostMapping("/ReadAllPayment")
    public List<Payment> ReadAllPayment(@RequestBody MemberLoggedInTokenForm memberLoggedInTokenForm){
        if (memberLoggedInTokenForm.getToken() == null|| memberLoggedInTokenForm.getToken().length() == 0){

            List<Payment> payments =  service.readManagerAllPayment();
            return payments;

        }else {
            String SubString = memberLoggedInTokenForm.getToken().substring(1,37);
            List<Payment> payments = service.readAllPayment(SubString);
            return payments;
        }
    }


    @PostMapping("/refundAllOrder/{refundPaymentId}")
    public Boolean refundAllOrder(@PathVariable("refundPaymentId") Long refundPaymentId, @RequestBody RefundRequest refundRequest) throws IamportResponseException, IOException {
        log.info("refundAllOrder" + refundPaymentId);
        log.info("refundAllOrder" + refundRequest.getRefundReason());
        log.info("refundAllOrder" + refundRequest.getRefundPaymentId());

        return service.refundAllOrder(refundRequest);

    }

    @PostMapping("/changeOrderState")
    public List<OrderInfo> changeOrderState( @RequestBody ChangeOrderStateRequest changeOrderStateRequest){
        log.info("주문상태 변경 주문아이디: " + changeOrderStateRequest.getOrderId());
        log.info("주문상태 변경 타입: " + changeOrderStateRequest.getReqType());
        log.info("주문상태 변경 결제번호: " + changeOrderStateRequest.getPaymentId());
        List<OrderInfo> orderInfoList = service.changeOrderState(changeOrderStateRequest);
        return orderInfoList;
    }

    @GetMapping(path = "/salesAmount")
    public Integer salesAmount() {
        return service.salesAmount();
    }

}
