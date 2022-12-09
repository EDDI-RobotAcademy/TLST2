package kr.eddi.ztz_process;

import kr.eddi.ztz_process.controller.order.request.AddCartRequest;
import kr.eddi.ztz_process.controller.order.request.CancelRequest;
import kr.eddi.ztz_process.controller.order.request.ModifyRequest;
import kr.eddi.ztz_process.controller.order.request.OrderRequest;
import kr.eddi.ztz_process.repository.member.MemberRepository;
import kr.eddi.ztz_process.repository.order.CartItemRepository;
import kr.eddi.ztz_process.repository.order.CartRepository;
import kr.eddi.ztz_process.repository.products.ProductsRepository;
import kr.eddi.ztz_process.service.order.CartService;
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

    @Autowired
    CartService cartService;

    @Autowired
    MemberRepository memberRepository;

    @Autowired
    CartRepository cartRepository;

    @Autowired
    CartItemRepository cartItemRepository;


    @Autowired
    ProductsRepository productsRepository;


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

    @Test
    void CreateCartItemTest(){

        AddCartRequest addCartRequest = new AddCartRequest(2L, 3L, 3);
        cartService.addCartItem(addCartRequest);

        System.out.println("장바구니 아이템 저장 테스트");
    }

    @Test
    void findCartItemListTest(){

        System.out.println("장바구니 아이템 조회 테스트: "+ cartItemRepository.findCartListByMemberId(1L));
    }

}
