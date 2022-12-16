package kr.eddi.ztz_process.controller.order.request;

import lombok.*;

import java.util.List;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class SelectCartItemRequest {

    private List<Long> selectCartItemNo;

}
