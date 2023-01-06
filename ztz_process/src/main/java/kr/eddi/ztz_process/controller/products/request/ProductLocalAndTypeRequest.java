package kr.eddi.ztz_process.controller.products.request;

import kr.eddi.ztz_process.entity.products.AlcoholType;
import kr.eddi.ztz_process.entity.products.Local;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Data
@NoArgsConstructor
public class ProductLocalAndTypeRequest {
    private String alcoholType;
    private String localName;


}
