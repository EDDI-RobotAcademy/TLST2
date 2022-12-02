package kr.eddi.ztz_process.entity.order;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.util.Date;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderInfo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long orderNo;

    @Column(nullable = false)
    private Integer orderID;

    @Column(nullable = false)
    private Integer orderCnt;

    @Column(nullable = false)
    private String orderedProductName;

    @Column(nullable = false)
    private String productThumbnailRoute;

    @Column(nullable = false)
    private Integer productPrice;

//    @ManyToOne
//    private Basket basket;
//
//    @ManyToOne
//    private MemberAddress memberAddress;

    @CreationTimestamp
    private Date regDate;

    @UpdateTimestamp
    private Date updDate;

    public void ModifyOrderCnt(Integer ModifyCnt){
        this.orderCnt = ModifyCnt;
    }

}
