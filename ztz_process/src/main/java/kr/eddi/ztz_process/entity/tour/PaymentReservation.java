package kr.eddi.ztz_process.entity.tour;

import jakarta.persistence.*;
import lombok.Data;


@Data
@Embeddable
public class PaymentReservation {
    @Column(nullable = false)
    private String merchant_uid;
    @Column(nullable = false)
    private Integer totalPaymentPrice;
    @Column(nullable = false)
    private boolean paymentState;

    public PaymentReservation(){
        this.merchant_uid = "000000";
        this.totalPaymentPrice = 0;
        this.paymentState = false;
    }

    public PaymentReservation(String merchant_uid, Integer totalPaymentPrice, boolean paymentState) {
        this.merchant_uid = merchant_uid;
        this.totalPaymentPrice = totalPaymentPrice;
        this.paymentState = paymentState;
    }

}
