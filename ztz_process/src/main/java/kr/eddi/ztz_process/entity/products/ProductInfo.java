package kr.eddi.ztz_process.entity.products;

import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Embeddable
@NoArgsConstructor
@AllArgsConstructor
public class ProductInfo {
    String ThumbnailFileName;
}
