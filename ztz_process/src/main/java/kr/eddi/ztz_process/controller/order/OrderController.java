package kr.eddi.ztz_process.controller.order;

import com.siot.IamportRestClient.exception.IamportResponseException;
import kr.eddi.ztz_process.controller.member.form.MemberLoggedInTokenForm;
import kr.eddi.ztz_process.controller.order.form.PaymentRegisterForm;
import kr.eddi.ztz_process.controller.order.request.RefundRequest;
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
        log.info("orderRegister" + paymentRegisterForm);

        return service.registerOrderInfo(paymentRegisterForm.toOrderRegisterRequest());
    }

    @PostMapping("/AllOrderCancel")
    public Boolean AllOrderCancel(CancelRequest cancelRequest){
        log.info("AllOrderCancel" + cancelRequest);

        return service.CancelAllOrder(cancelRequest);
    }

    @PostMapping("/ReadAllPayment")
    public List<Payment> ReadAllPayemt(@RequestBody MemberLoggedInTokenForm memberLoggedInTokenForm){
        String SubString = memberLoggedInTokenForm.getToken().substring(1,37);

        List<Payment> payments = service.readAllPayment(SubString);
        return payments;
    }

}
