package kr.eddi.ztz_process.entity.boards;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum BoardCategoryType {

    ORDER_PAYMENT("주문/결제문의"),
    PRODUCT("상품문의"),
    DELIVERY("배송문의"),
    RETURN_CHANGE("반품/교환문의"),
    TOUR("양조장문의"),
    OTHER("기타문의");

    private final String boardCategory;

}
