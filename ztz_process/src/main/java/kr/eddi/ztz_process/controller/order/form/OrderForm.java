package kr.eddi.ztz_process.controller.order.form;

import kr.eddi.ztz_process.service.order.request.ReceivedOrderItem;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class OrderForm {
    private String token;
    private String impUid;
    private String merchantUid;
    private List<ReceivedOrderItem> items;
    private String deliveryMessage;


}
