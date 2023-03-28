package kr.eddi.ztz_process.controller.order;

import com.siot.IamportRestClient.exception.IamportResponseException;
import kr.eddi.ztz_process.controller.member.form.MemberLoggedInTokenForm;
import kr.eddi.ztz_process.controller.order.form.OrderForm;
import kr.eddi.ztz_process.controller.order.form.PaymentDataRangeForm;
import kr.eddi.ztz_process.controller.order.form.PaymentRegisterForm;
import kr.eddi.ztz_process.controller.order.request.RefundRequest;
import kr.eddi.ztz_process.controller.order.request.ChangeOrderStateRequest;
import kr.eddi.ztz_process.entity.order.OrderInfo;
import kr.eddi.ztz_process.entity.order.Payment;
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
        return service.registerOrderInfo(paymentRegisterForm.toOrderRegisterRequest());
    }

    @PostMapping("/ReadAllOrder/{paymentId}")
    public List<OrderInfo> ReadAllOrder(@PathVariable("paymentId") Long paymentId){
        List<OrderInfo> orderInfoList = service.readAllOrders(paymentId);
        return orderInfoList;
    }

    @PostMapping("/ReadAllPayment")
    public List<Payment> ReadAllPayment(@RequestBody MemberLoggedInTokenForm memberLoggedInTokenForm){
        if (memberLoggedInTokenForm.getToken() == null|| memberLoggedInTokenForm.getToken().length() == 0){

            List<Payment> payments =  service.readManagerAllPayment();
            return payments;

        }else {
            String SubString = "";
            if(memberLoggedInTokenForm.getToken().length() >= 37){
                SubString = memberLoggedInTokenForm.getToken().substring(1,37);
            }else {
                SubString = memberLoggedInTokenForm.getToken();
            }
            List<Payment> payments = service.readAllPayment(SubString);
            return payments;
        }
    }

    @PostMapping("/readPayment/byDate")
    public List<Payment> readPaymentByData(@RequestBody PaymentDataRangeForm paymentDataRangeForm){
        String readData = paymentDataRangeForm.getReadData();
        String SubString = "";
        if(paymentDataRangeForm.getToken().length() >= 37){
            SubString = paymentDataRangeForm.getToken().substring(1,37);
        }else {
            SubString = paymentDataRangeForm.getToken();
        }
        List<Payment> payments = service.readRangePaymentList(SubString, readData);

        return payments;
    }

    @PostMapping("/refundAllOrder/{refundPaymentId}")
    public Boolean refundAllOrder(@PathVariable("refundPaymentId") Long refundPaymentId, @RequestBody RefundRequest refundRequest) throws IamportResponseException, IOException {
        return service.refundAllOrder(refundRequest);
    }

    @PostMapping("/changeOrderState")
    public List<OrderInfo> changeOrderState( @RequestBody ChangeOrderStateRequest changeOrderStateRequest){
        List<OrderInfo> orderInfoList = service.changeOrderState(changeOrderStateRequest);
        return orderInfoList;
    }

    @GetMapping(path = "/salesAmount")
    public Integer salesAmount() {
        return service.salesAmount();
    }


    @PostMapping("/save-order")
    public Boolean order(@RequestBody OrderForm orderForm){
        return service.registerOrderInfo(orderForm);
    }
    @PostMapping("/writableReview")
    public List<OrderInfo> writableReview(@RequestBody MemberLoggedInTokenForm form){
        String SubString = "";
        if(form.getToken().length() >= 37){
            SubString = form.getToken().substring(1,37);
        }else {
            SubString = form.getToken();
        }
        List<OrderInfo> orderInfoList = service.reviewWritableList(SubString);
        return orderInfoList;
    }

    @PostMapping("/readOrder/{orderInfoId}")
    public OrderInfo readOrderInfo(@PathVariable("orderInfoId") Long orderInfoId){
        return service.readOrder(orderInfoId);
    }
}
