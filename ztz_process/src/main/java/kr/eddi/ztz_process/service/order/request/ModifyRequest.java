package kr.eddi.ztz_process.service.order.request;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Data
@ToString
@RequiredArgsConstructor
public class ModifyRequest {
    private final Integer MemberNo;
    private final Integer orderID;
    private final String ProductName;
    private final Integer ModifyCnt;
}
