package kr.eddi.ztz_process.controller.products.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ReviewRequest {
    private Long memberId;
    private Long productNo;
    private Double rate;
    private String content;
    private Long orderId;
}
