package kr.eddi.ztz_process.controller.order.request;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ChangeOrderStateRequest {

    private String reqType;
    private Long orderId;
    private Long paymentId;
}
