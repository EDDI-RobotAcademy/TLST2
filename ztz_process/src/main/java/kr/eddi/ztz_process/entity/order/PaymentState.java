package kr.eddi.ztz_process.entity.order;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.Arrays;

@Getter
@RequiredArgsConstructor
public enum PaymentState {

    PAYMENT_COMPLETE("결제완료"), PAYMENT_REFUND("환불완료"), DELIVERY_START("배송시작"), DELIVERY_ONGOING("배송중"),
    PART_DELIVERY_ONGOING("부분배송중"),DELIVERY_COMPLETE("배송완료"), PAYMENT_CONFIRM("구매확정"), REFUND_REQUEST("반품신청"),
    WRITE_REVIEW("리뷰작성 완료") , PART_WRITE_REVIEW("일부 리뷰작성 완료") , ABLE_WRITE_REVIEW("리뷰작성 가능");


    final private String state;

    public static PaymentState valueOfPaymentState(String state) {
        return Arrays.stream(values())
                .filter(value -> value.state.equals(state))
                .findAny()
                .orElse(null);
    }
}
