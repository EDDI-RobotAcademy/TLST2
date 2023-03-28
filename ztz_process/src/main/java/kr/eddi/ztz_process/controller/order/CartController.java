package kr.eddi.ztz_process.controller.order;


import kr.eddi.ztz_process.controller.order.request.AddCartRequest;
import kr.eddi.ztz_process.controller.order.request.ChangeItemCountRequest;
import kr.eddi.ztz_process.controller.order.request.SelectCartItemRequest;
import kr.eddi.ztz_process.entity.order.Item;
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


    @PostMapping("/delete-items")
    public void deleteCartItem(@RequestBody SelectCartItemRequest selectCartItemRequest) {
        service.deleteCartItem(selectCartItemRequest);
    }

    @PostMapping("/add")
    public String addCartItem(@RequestBody AddCartRequest addCartRequest){
        service.addProductInCart(addCartRequest);
        return "1";
    }

    @GetMapping(path = "/myCart", headers = "Token")
    public List<Item> cartItemList(@RequestHeader("Token") String token) {
        String userToken = token;
        return service.returnCartItemList(token);
    }

    @DeleteMapping(path = "/{itemNo}", headers = "Token")
    public String deleteItem (@PathVariable("itemNo") Long itemNo, @RequestHeader("Token") String token) {
        if(itemNo == 1000001) {
            log.info("direct 구매 ");
        } else {
            service.deleteCartItem(itemNo, token);
        }
        return "1";
    }

    @PostMapping(path = "/change-item-count")
    public String changeCountAndTotalAmount (@RequestBody ChangeItemCountRequest changeItemCountRequest) {
        service.changeCartItemCount(changeItemCountRequest);
        return "1";
    }

}
