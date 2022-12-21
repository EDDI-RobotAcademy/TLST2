package kr.eddi.ztz_process.entity.products;

import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@Embeddable
@NoArgsConstructor
@AllArgsConstructor
public class ProductInfo {
    String thumbnailFileName;

    List<String> productImagesName;

    List<String> taste;

    String subTitle;

    String description;

}
