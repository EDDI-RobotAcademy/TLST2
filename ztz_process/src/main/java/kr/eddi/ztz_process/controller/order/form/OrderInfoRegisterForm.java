package kr.eddi.ztz_process.controller.order.form;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class OrderInfoRegisterForm {

    private List<Long> productID;

    private List<Long> memberID;

    private List<Integer> orderCnt;

    private List<Integer> orderPrice;

    public OrderInfoRegisterForm(List<Long> productID,List<Long> memberID,List<Integer> OrderCnt, List<Integer> orderPrice){
        this.productID = productID;
        this.memberID = memberID;
        this.orderCnt = OrderCnt;
        this.orderPrice = orderPrice;
    }
}
