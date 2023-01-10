package kr.eddi.ztz_process.controller.order.request;

import lombok.Data;
import lombok.Getter;

@Data
public class ChangeItemCountRequest {

    private Long itemNo;
    private int count;
    private int selectedProductAmount;
}
