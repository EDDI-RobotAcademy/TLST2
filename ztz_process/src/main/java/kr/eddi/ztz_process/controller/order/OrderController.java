package kr.eddi.ztz_process.controller.order;

import kr.eddi.ztz_process.controller.order.request.CancelRequest;
import kr.eddi.ztz_process.controller.order.request.ModifyRequest;
import kr.eddi.ztz_process.controller.order.request.OrderRequest;
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
        log.info("orderInfoList" + orderRequest);
        return service.orderInfoList(orderRequest);
    }

    @PostMapping("/OrderRegister")
    public Boolean orderRegister(List<OrderRequest> orderRequest){
        log.info("orderRegister" + orderRequest);

        return service.registerOrderInfo(orderRequest);
    }

    @PostMapping("/AllOrderCancel")
    public Boolean AllOrderCancel(CancelRequest cancelRequest){
        log.info("AllOrderCancel" + cancelRequest);

        return service.CancelAllOrder(cancelRequest);
    }

        return false;
    }

}
