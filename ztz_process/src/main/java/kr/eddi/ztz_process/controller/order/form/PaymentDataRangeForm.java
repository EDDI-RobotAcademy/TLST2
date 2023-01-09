package kr.eddi.ztz_process.controller.order.form;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PaymentDataRangeForm {
    String token;
    String readData;
}
