package kr.eddi.ztz_process;

import kr.eddi.ztz_process.controller.order.form.OrderInfoRegisterForm;
import kr.eddi.ztz_process.repository.member.MemberRepository;
import kr.eddi.ztz_process.repository.order.CartItemRepository;
import kr.eddi.ztz_process.repository.order.CartRepository;
import kr.eddi.ztz_process.repository.products.ProductsRepository;
import kr.eddi.ztz_process.service.order.CartService;
import kr.eddi.ztz_process.service.order.OrderService;
import kr.eddi.ztz_process.service.order.request.CancelRequest;
import kr.eddi.ztz_process.service.order.request.ModifyRequest;
import kr.eddi.ztz_process.service.order.request.PaymentRegisterRequest;
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
        List<OrderInfoRegisterForm> orderInfoRegisterForms = new ArrayList<>();
        orderInfoRegisterForms.add(new OrderInfoRegisterForm(1L,1L,1));
        orderInfoRegisterForms.add(new OrderInfoRegisterForm(2L,1L,1));
        PaymentRegisterRequest paymentRegisterRequestList = new PaymentRegisterRequest(10000,"pay_id",orderInfoRegisterForms);

        orderService.registerOrderInfo(paymentRegisterRequestList);
        //orderService.registerOrderInfo(paymentRegisterRequestList);
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

        kr.eddi.ztz_process.controller.order.request.AddCartRequest addCartRequest = new kr.eddi.ztz_process.controller.order.request.AddCartRequest(2L, 3L, 3);
        cartService.addCartItem(addCartRequest);

        System.out.println("장바구니 아이템 저장 테스트");
    }

    @Test
    void findCartItemListTest(){

        System.out.println("장바구니 아이템 조회 테스트: "+ cartItemRepository.findCartListByMemberId(1L));
    }

    @Test
    void deleteCartItemTest(){

        cartItemRepository.deleteById(3L);

        System.out.println("장바구니 아이템 삭제 테스트");
    }

}
