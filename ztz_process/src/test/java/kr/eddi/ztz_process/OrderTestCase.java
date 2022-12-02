package kr.eddi.ztz_process;

import kr.eddi.ztz_process.controller.order.request.CancelRequest;
import kr.eddi.ztz_process.controller.order.request.ModifyRequest;
import kr.eddi.ztz_process.controller.order.request.OrderRequest;
import kr.eddi.ztz_process.service.order.OrderService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;

@SpringBootTest
public class OrderTestCase {

    @Autowired
    OrderService orderService;

    @Test
    void OrderRegisterTest(){
        List<OrderRequest> orderRequestList = new ArrayList<>();
        orderRequestList.add(new OrderRequest(1,1,1));

        orderService.registerOrderInfo(orderRequestList);
    }

    @Test
    void CancelAllOrderTest(){
        CancelRequest cancelRequest = new CancelRequest(1,78636);

        orderService.CancelAllOrder(cancelRequest);
    }

    @Test
    void ModifyOrderCnt(){
        List<ModifyRequest> modifyRequest = new ArrayList<>();
        modifyRequest.add(new ModifyRequest(1,2330,"테스트상품",0));

        orderService.ModifyOrder(modifyRequest);
    }
}
