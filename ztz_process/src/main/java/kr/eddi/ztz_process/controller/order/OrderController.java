package kr.eddi.ztz_process.controller.order;

import kr.eddi.ztz_process.entity.order.ResponseOrderInfo;
import kr.eddi.ztz_process.repository.order.OrderRequest;
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
@RequestMapping("/order")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class OrderController {


    @Autowired
    private OrderService service;

    @PostMapping("/OrderList")
    public List<ResponseOrderInfo> orderInfoList(List<OrderRequest> orderRequest) {
        log.info("orderInfoList");
        return service.orderInfoList(orderRequest);
    }

    @PostMapping("/OrderRegister")
    public Boolean orderRegister(){
        log.info("orderRegister");

        return false;
    }

}
