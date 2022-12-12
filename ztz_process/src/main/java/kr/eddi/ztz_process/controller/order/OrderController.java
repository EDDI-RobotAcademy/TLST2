package kr.eddi.ztz_process.controller.order;

import kr.eddi.ztz_process.service.order.request.CancelRequest;
import kr.eddi.ztz_process.service.order.request.ModifyRequest;
import kr.eddi.ztz_process.service.order.request.PaymentRegisterRequest;
import kr.eddi.ztz_process.service.order.OrderService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("order")
@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")
public class OrderController {


    @Autowired
    private OrderService service;

    @PostMapping("/OrderRegister")
    public Boolean orderRegister(PaymentRegisterRequest paymentRegisterRequest){
        log.info("orderRegister" + paymentRegisterRequest);

        return service.registerOrderInfo(paymentRegisterRequest);
    }

    @PostMapping("/AllOrderCancel")
    public Boolean AllOrderCancel(CancelRequest cancelRequest){
        log.info("AllOrderCancel" + cancelRequest);

        return service.CancelAllOrder(cancelRequest);
    }

    @PostMapping("/OrderModify")
    public Boolean OrderModify(List<ModifyRequest> modifyRequest){
        log.info("OrderModify" + modifyRequest);

        return service.ModifyOrder(modifyRequest);
    }

}
