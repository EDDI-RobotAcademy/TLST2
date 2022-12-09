package kr.eddi.ztz_process.service.order;

import kr.eddi.ztz_process.controller.order.request.AddCartRequest;
import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.entity.order.Cart;
import kr.eddi.ztz_process.entity.order.CartItem;
import kr.eddi.ztz_process.entity.products.Product;
import kr.eddi.ztz_process.repository.member.MemberRepository;
import kr.eddi.ztz_process.repository.order.CartItemRepository;
import kr.eddi.ztz_process.repository.order.CartRepository;
import kr.eddi.ztz_process.repository.products.ProductsRepository;
import kr.eddi.ztz_process.service.security.RedisService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@Slf4j
public class CartServiceImpl implements CartService {

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private CartItemRepository cartItemRepository;

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private ProductsRepository productsRepository;

    @Autowired
    private RedisService redisService;

    @Override
    public void addCartItem(AddCartRequest addCartRequest){//Long memberId, Long productId, Long count
       Long memberId = addCartRequest.getMemberId();
       Long productId = addCartRequest.getProductId();
       int count = addCartRequest.getCount();;

        Optional<Cart> maybeCart = cartRepository.findByMemberId(memberId);

        //1. 해당 멤버의 장바구니 없는 경우 생성
        if(maybeCart.isEmpty()){
            Optional<Member> maybeMember = memberRepository.findById(memberId);
            Member member = maybeMember.get();

            Cart firstCart = Cart.builder()
                    .member(member)
                    .totalCount(0)
                    .build();
            cartRepository.save(firstCart);
            log.info("카트 최초 생성");
        } else {
            log.info("이미 해당 회원의 카트가 있음");
        }

        //2. 멤버 아이디 기준으로 해당 cart 정보 get -> 카트 최초생성 시 없으면 새로 만든 것 적용하여 다시 조회
        Optional<Cart> maybeYesCart = cartRepository.findByMemberId(memberId);
        Cart cart = maybeYesCart.get();

        //3. 상품 아이디 기준으로 해당 상품 정보 get
        Optional<Product> maybeProduct = productsRepository.findById(productId);
        Product product = maybeProduct.get();

        //4. 해당 회원의 장바구니에 아이템 등록
        CartItem cartItem = CartItem.builder()
                .cart(cart)
                .product(product)
                .count(count)           //실제 장바구니 아이템A의 갯수
                .build();

        //카트에 아이템 저장 시 뱃지 알림용-> 한 회원의 장바구니 아이템 갯수
        cart.setTotalCount(cart.getTotalCount()+1);
        cartRepository.save(cart);
        cartItemRepository.save(cartItem);

    }
    public List<CartItem> cartList(String userToken){
        //유저토큰으로 멤버 아이디 찾기
        Long id = redisService.getValueByKey(userToken);
        return cartItemRepository.findCartListByMemberId(id);
    }
}