package kr.eddi.ztz_process.repository.order;

import jakarta.persistence.criteria.CriteriaBuilder;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Data
@ToString
@RequiredArgsConstructor
public class OrderRequest {
    private final Integer ProductNo;
    private final Integer OrderCnt;
    private final Integer MemberNo;
}
