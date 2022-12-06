package kr.eddi.ztz_process.controller.order.request;

import jakarta.persistence.criteria.CriteriaBuilder;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Data
@ToString
@RequiredArgsConstructor
public class CancelRequest {
    private final Integer MemberNo;
    private final Integer orderID;
}
