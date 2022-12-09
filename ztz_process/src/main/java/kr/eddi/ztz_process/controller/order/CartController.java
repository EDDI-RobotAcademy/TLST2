package kr.eddi.ztz_process.controller.order;


import kr.eddi.ztz_process.controller.order.request.AddCartRequest;
import kr.eddi.ztz_process.service.order.CartService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


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


}
