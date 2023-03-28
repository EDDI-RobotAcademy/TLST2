package kr.eddi.ztz_process.service.order;

import kr.eddi.ztz_process.controller.order.request.AddCartRequest;
import kr.eddi.ztz_process.controller.order.request.ChangeItemCountRequest;
import kr.eddi.ztz_process.controller.order.request.SelectCartItemRequest;
import kr.eddi.ztz_process.entity.order.Item;

import java.util.List;

public interface CartService {
    public void deleteCartItem(SelectCartItemRequest selectCartItemRequest);

    List<Item> returnCartItemList(String userToken);
    List<Item> deleteCartItem(long itemNo, String token);
    String changeCartItemCount (ChangeItemCountRequest changeItemCountRequest);
    String addProductInCart(AddCartRequest addCartRequest);
    Item isExistItemCheck(AddCartRequest addCartRequest, long id);


}
