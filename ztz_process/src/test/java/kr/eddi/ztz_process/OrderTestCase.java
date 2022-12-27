package kr.eddi.ztz_process;

import kr.eddi.ztz_process.controller.order.form.OrderInfoRegisterForm;
import kr.eddi.ztz_process.controller.order.request.ChangeOrderStateRequest;
import kr.eddi.ztz_process.repository.member.MemberRepository;
import kr.eddi.ztz_process.repository.order.CartItemRepository;
import kr.eddi.ztz_process.repository.order.CartRepository;
import kr.eddi.ztz_process.repository.products.ProductsRepository;
import kr.eddi.ztz_process.service.order.CartService;
import kr.eddi.ztz_process.service.order.OrderService;
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
        List<Long> test1 = new ArrayList<>();
        test1.add(1L);
        List<Integer> test2 = new ArrayList<>();
        test2.add(1);
        OrderInfoRegisterForm orderInfoRegisterForms = new OrderInfoRegisterForm(test1,test1,test2);

        PaymentRegisterRequest paymentRegisterRequestList = new PaymentRegisterRequest(
                10000,"pay_id",orderInfoRegisterForms, "impid0000", "서울", "동대문구", "휘경동", "10202", "sendRequest");

        orderService.registerOrderInfo(paymentRegisterRequestList);
        orderService.registerOrderInfo(paymentRegisterRequestList);
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

    @Test
    void readManagerAllPaymentTest(){
        System.out.println("전체 결제주문리스트 조회: "+orderService.readManagerAllPayment());
    }

    @Test
    void changeOrderStateTest(){
        ChangeOrderStateRequest request = new ChangeOrderStateRequest("배송시작", 11L, 6L);
        orderService.changeOrderState(request);
    }
}
