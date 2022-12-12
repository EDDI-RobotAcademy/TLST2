package kr.eddi.ztz_process.entity.products;

import lombok.Data;
import jakarta.persistence.*;
import lombok.NoArgsConstructor;

@Data
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
    private Long price;

    @Embedded
    private Classification classification;
    @Embedded
    private ProductInfo productInfo;

    public Product(String brand, String name, Long price, Classification classification,ProductInfo productInfo) {
        this.brand = brand;
        this.name = name;
        this.price = price;
        this.classification = classification;
        this.productInfo = productInfo;
    }


}
