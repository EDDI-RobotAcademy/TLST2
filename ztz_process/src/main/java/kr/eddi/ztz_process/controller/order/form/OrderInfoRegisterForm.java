package kr.eddi.ztz_process.controller.order.form;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.aspectj.weaver.ast.Or;

import java.util.List;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class OrderInfoRegisterForm {

    private List<Long> productID;

    private List<Long> memberID;

    private List<Integer> orderCnt;

    public OrderInfoRegisterForm(List<Long> productID,List<Long> memberID,List<Integer> OrderCnt){
        this.productID = productID;
        this.memberID = memberID;
        this.orderCnt = OrderCnt;
    }
}
