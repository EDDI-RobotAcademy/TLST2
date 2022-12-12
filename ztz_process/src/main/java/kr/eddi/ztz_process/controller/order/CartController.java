package kr.eddi.ztz_process.controller.order;


import kr.eddi.ztz_process.controller.member.form.MemberLoggedInTokenForm;
import kr.eddi.ztz_process.controller.order.request.AddCartRequest;
import kr.eddi.ztz_process.controller.order.request.SelectCartItemRequest;
import kr.eddi.ztz_process.entity.order.CartItem;
import kr.eddi.ztz_process.service.order.CartService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@Slf4j
@RestController
@RequestMapping("ztz/order")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class CartController {

    @Autowired
    private CartService service;


    @PostMapping("/addCartItem/{memberId}")
    public void registerCartItem(@PathVariable("memberId") Long memberId, @RequestBody AddCartRequest addCartRequest) {
        log.info("카트 아이템 넣기 멤버 아이디: " + memberId + "카트상품번호: "+addCartRequest.getProductId() + "카트수량"+ addCartRequest.getCount());

        service.addCartItem(addCartRequest.toAddCartRequest());
    }

    @PostMapping("/cartList")
    public List<CartItem> cartList(@RequestBody MemberLoggedInTokenForm memberLoggedInTokenForm) {
        String userToken = memberLoggedInTokenForm.getToken().substring(1,37);

        log.info("회원 카트리스트 조회 후 리턴");
        return service.cartList(userToken);
    }

    @PostMapping("/deleteCartItem")
    public void deleteCartItem(@RequestBody SelectCartItemRequest selectCartItemRequest) {

        log.info("회원 카트 아이템 삭제");
        service.deleteCartItem(selectCartItemRequest);
    }

}
