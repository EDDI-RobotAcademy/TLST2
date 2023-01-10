package kr.eddi.ztz_process.controller.order;


import kr.eddi.ztz_process.controller.order.request.AddCartRequest;
import kr.eddi.ztz_process.controller.order.request.ChangeItemCountRequest;
import kr.eddi.ztz_process.controller.order.request.SelectCartItemRequest;
import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.entity.order.Cart;
import kr.eddi.ztz_process.entity.products.Product;
import kr.eddi.ztz_process.entity.order.Item;
import kr.eddi.ztz_process.repository.member.MemberRepository;
import kr.eddi.ztz_process.repository.order.CartRepository;
import kr.eddi.ztz_process.repository.order.ItemRepository;
import kr.eddi.ztz_process.repository.products.ProductsRepository;
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


//    @PostMapping("/addCartItem/{memberId}")
//    public void registerCartItem(@PathVariable("memberId") Long memberId, @RequestBody AddCartRequest addCartRequest) {
//        log.info("카트 아이템 넣기 멤버 아이디: " + memberId + "카트상품번호: "+addCartRequest.getProductId() + "카트수량"+ addCartRequest.getCount());
//
//        service.addCartItem(addCartRequest.toAddCartRequest());
//    }

    @PostMapping("/delete-items")
    public void deleteCartItem(@RequestBody SelectCartItemRequest selectCartItemRequest) {
        log.info("회원 카트 선택된 아이템 삭제");
        service.deleteCartItem(selectCartItemRequest);
    }

    @PostMapping("/add")
    public String addCartItem(@RequestBody AddCartRequest addCartRequest){
        log.info("새로운 카트담기 메서드 테스트 :" +addCartRequest);
        service.addProductInCart(addCartRequest);
        return "1";
    }

    @GetMapping(path = "/myCart", headers = "Token")
    public List<Item> cartItemList(@RequestHeader("Token") String token) {
        String userToken = token;
        log.info("flutter용 겟 " + service.returnCartItemList(token) + "토큰 길이" + token.length());
        return service.returnCartItemList(token);
    }

    @DeleteMapping(path = "/{itemNo}", headers = "Token")
    public String deleteItem (@PathVariable("itemNo") Long itemNo, @RequestHeader("Token") String token) {
        log.info("선택된 단일 항목 삭()" + itemNo + " : " + token );
        service.deleteCartItem(itemNo, token);
        return "1";
    }


    @PostMapping(path = "/change-item-count")
    public String changeCountAndTotalAmount (@RequestBody ChangeItemCountRequest changeItemCountRequest) {
        log.info("changeCountAndTotalAmount()" + changeItemCountRequest.toString() );
        service.changeCartItemCount(changeItemCountRequest);
        return "1";
    }


//    @Autowired
//    MemberRepository memberRepository;
//    @Autowired
//    ItemRepository itemRepository;
//    @Autowired
//    CartRepository cartRepository;
//    @Autowired
//    ProductsRepository productsRepository;
//
//    @GetMapping(path = "/test")
//    public void saveItemsInCart(){
//        log.info("통신와료");
//        Long memberId = 1L;
//        Long productId = 1L;
//
//        Member member = memberRepository.findByMemberId(memberId);
////
////        Cart firstCart = Cart.builder()
////                .member(member)
////                .build();
////
////        cartRepository.save(firstCart);
////
////        log.info("카트 최초 생성" + firstCart.getCartNo());
//
//
//
//        Cart cart = cartRepository.findCartByMemberId(memberId);
//        Product product = productsRepository.findProductByProductNo(productId);
//        int count = 2;
//        int count2 = 1;
//        int totalMount = count * product.getPrice();
////        // id로 해당 멤버의 cart 찾기
////        // cart 안의 cartItem Set에 해당 product id와 숫자 , 토탈 금액 추가하기
////        // cart 뽑기
////
//        // id , cart, product, count, amounttotal
//        Item item1 = new Item(
//                cart, product, count, totalMount
//        );
//        Item item2 = new Item(
//                cart, product, 1, count2 * product.getPrice()
//        );
//
//
//        itemRepository.save(item1);
//        itemRepository.save(item2);
//
//
//    }


}
