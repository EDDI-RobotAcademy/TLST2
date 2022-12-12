package kr.eddi.ztz_process.controller.order.form;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.aspectj.weaver.ast.Or;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class OrderInfoRegisterForm {

    private Long productID;

    private Long MemberID;

    private Integer OrderCnt;

    public OrderInfoRegisterForm(Long productID,Long memberID,Integer OrderCnt){
        this.productID = productID;
        this.MemberID = memberID;
        this.OrderCnt = OrderCnt;
    }
}
