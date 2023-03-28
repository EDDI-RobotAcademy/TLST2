package kr.eddi.ztz_process.service.order;

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
import kr.eddi.ztz_process.service.security.RedisService;
import kr.eddi.ztz_process.utility.order.validationToken;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
@Slf4j
public class CartServiceImpl implements CartService {

    @Autowired
    private CartRepository cartRepository;
    @Autowired
    ItemRepository itemRepository;
    @Autowired
    private MemberRepository memberRepository;
    @Autowired
    private ProductsRepository productsRepository;
    @Autowired
    private RedisService redisService;



    public void deleteCartItem(SelectCartItemRequest selectCartItemRequest){
        List<Long> deleteCartItemNo = selectCartItemRequest.getSelectCartItemNo();

        for (int i = 0; i <deleteCartItemNo.size() ; i++) {
            itemRepository.deleteById(deleteCartItemNo.get(i));
        }
    }
    public List<Item> returnCartItemList(String userToken){
        String returnToken = validationToken.validationToken(userToken);
        Long id = redisService.getValueByKey(returnToken);

        return itemRepository.findCartListByMemberId(id);
    }
    @Override
    public List<Item> deleteCartItem(long itemNo, String token) {
        String returnToken = validationToken.validationToken(token);
        Long id = redisService.getValueByKey(returnToken);
        itemRepository.deleteById(itemNo);

        return itemRepository.findCartListByMemberId(id);
    }
    @Override
    public String changeCartItemCount(ChangeItemCountRequest changeItemCountRequest) {
        Item item = itemRepository.findItemByItemNo(changeItemCountRequest.getItemNo());

        item.setCount(changeItemCountRequest.getCount());
        item.setSelectedProductAmount(changeItemCountRequest.getSelectedProductAmount());

        itemRepository.save(item);
        return "1";
    }
    @Override
    public String addProductInCart(AddCartRequest addCartRequest) {
        String returnToken = validationToken.validationToken(addCartRequest.getToken());
        Long id = redisService.getValueByKey(returnToken);

        Optional<Cart> maybeCart = cartRepository.findByMemberId(id);

        if(maybeCart.isEmpty()){
            Optional<Member> maybeMember = memberRepository.findById(id);
            Member member = maybeMember.get();

            Cart firstCart = Cart.builder()
                    .member(member)
                    .totalCount(0)
                    .build();
            cartRepository.save(firstCart);
        } else {
            log.info("이미 해당 회원의 카트가 있음");
        }

        List<Item> myCartItems = itemRepository.findCartListByMemberId(id);
        Long productNo = addCartRequest.getProductNo();
        if(!myCartItems.isEmpty()) {
            Item isExistItem = isExistItemCheck(addCartRequest, id);
            if(isExistItem == null) {
                Cart cart = cartRepository.findCartByMemberId(id);
                int count = addCartRequest.getCount();
                Product product = productsRepository.findProductByProductNo(productNo);

                int totalMount = count * product.getPrice();
                Item item1 = new Item(cart, product, count, totalMount);

                itemRepository.save(item1);
            } else {
                int addCount = isExistItem.getCount() + addCartRequest.getCount();
                isExistItem.setCount(addCount);
                isExistItem.setSelectedProductAmount(addCount * isExistItem.getProduct().getPrice());
                itemRepository.save(isExistItem);
            }

        } else {
            Cart cart = cartRepository.findCartByMemberId(id);
            int count = addCartRequest.getCount();
            Product product = productsRepository.findProductByProductNo(productNo);

            int totalMount = count * product.getPrice();
            Item item1 = new Item(cart, product, count, totalMount);

            itemRepository.save(item1);
        }
        return "success";
    }

    @Override
    public Item isExistItemCheck(AddCartRequest addCartRequest, long id) {

        List<Item> myCartItems = itemRepository.findCartListByMemberId(id);
        Long productNo = addCartRequest.getProductNo();

        for (Item item : myCartItems) {
            if(Objects.equals(item.getProduct().getProductNo(), productNo)) {
                return item;
            }
        }
        return null;
    }

}