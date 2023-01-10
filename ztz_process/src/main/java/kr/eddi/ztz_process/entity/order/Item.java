package kr.eddi.ztz_process.entity.order;

import jakarta.persistence.*;
import kr.eddi.ztz_process.entity.order.Cart;
import kr.eddi.ztz_process.entity.products.Product;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Item {

    @Id
    @GeneratedValue
    private Long itemNo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CART_ID")
    private Cart cart;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PRODUCT_ID")
    private Product product;

    @Column(nullable = false)
    private int count;

    @Column(nullable = false)
    private int selectedProductAmount;

    public Item(
            Cart cart,
            Product product,
            int count,
            int selectedProductAmount
    ) {
        this.cart = cart;
        this.product = product;
        this.count = count;
        this.selectedProductAmount = selectedProductAmount;
    }
}
