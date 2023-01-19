package kr.eddi.ztz_process.entity.products;

import lombok.*;
import jakarta.persistence.*;

@Getter
@Setter
@Entity
@NoArgsConstructor
public class Product {
    @Id
    @Column(name = "product_no")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long productNo;

    @Column(nullable = false)
    private String brand;
    @Column(nullable = false)
    private String name;
    @Column(nullable = false)
    private Integer price;

    @Column
    private Integer view = 0;

    @Column
    private Integer favoriteNum = 0;

    @Column(nullable = false, columnDefinition = "TINYINT(1)")
    Boolean monthAlcoholCheck = false;

    @Embedded
    private Classification classification;
    @Embedded
    private ProductInfo productInfo;

    public Product(String brand, String name, int price, Classification classification,ProductInfo productInfo) {
        this.brand = brand;
        this.name = name;
        this.price = price;
        this.classification = classification;
        this.productInfo = productInfo;
    }


}
