package kr.eddi.ztz_process.controller.order.request;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class AddCartRequest {
    private Long memberId;
    private Long productId;
    private int count;

    public AddCartRequest toAddCartRequest() {
        return new AddCartRequest(memberId, productId, count);
    }
}

