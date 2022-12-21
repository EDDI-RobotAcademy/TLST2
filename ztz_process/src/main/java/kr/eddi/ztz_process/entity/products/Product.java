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

    @Column(nullable = false)
    private Integer deliveryFee;

    @Embedded
    private Classification classification;
    @Embedded
    private ProductInfo productInfo;

    public Product(String brand, String name, int price, int deliveryFee, Classification classification,ProductInfo productInfo) {
        this.brand = brand;
        this.name = name;
        this.price = price;
        this.deliveryFee = deliveryFee;
        this.classification = classification;
        this.productInfo = productInfo;
    }


}
