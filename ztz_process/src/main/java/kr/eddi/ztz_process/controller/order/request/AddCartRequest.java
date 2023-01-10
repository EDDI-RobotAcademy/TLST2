package kr.eddi.ztz_process.controller.order.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AddCartRequest {
    //private Long memberId;
    private Long productNo;
    private int count;
    private String token;

    public AddCartRequest toAddCartRequest() {
        return new AddCartRequest(productNo, count, token);
    }
}