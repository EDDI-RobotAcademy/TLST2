package kr.eddi.ztz_process.controller.order;

import kr.eddi.ztz_process.controller.order.form.PaymentRegisterForm;
import kr.eddi.ztz_process.service.order.request.CancelRequest;
import kr.eddi.ztz_process.service.order.request.ModifyRequest;
import kr.eddi.ztz_process.service.order.request.PaymentRegisterRequest;
import kr.eddi.ztz_process.service.order.OrderService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping("/OrderModify")
    public Boolean OrderModify(List<ModifyRequest> modifyRequest){
        log.info("OrderModify" + modifyRequest);

        return service.ModifyOrder(modifyRequest);
    }

}
