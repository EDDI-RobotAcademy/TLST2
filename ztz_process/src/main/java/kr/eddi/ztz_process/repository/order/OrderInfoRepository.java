package kr.eddi.ztz_process.repository.order;

import kr.eddi.ztz_process.entity.order.OrderInfo;
import kr.eddi.ztz_process.entity.order.PaymentState;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface OrderInfoRepository extends JpaRepository<OrderInfo, Long> {
    @Query("select o from OrderInfo o where o.orderNo = :orderNo")
    Optional<OrderInfo> findByOrderNo(String orderNo);
    @Query("select o from OrderInfo o where o.member.id = :memberId")
    List<OrderInfo> findByMemberId(Long memberId);
    @Query("select o from OrderInfo o join fetch o.payment join fetch o.member join fetch o.product where o.orderID = :orderID")
    Optional<OrderInfo> findByOrderID(Long orderID);
    @Query("select o from OrderInfo o join fetch o.payment join fetch o.member join fetch o.product where o.payment.paymentId = :paymentId")
    List<OrderInfo> findByPaymentId(Long paymentId);

    @Query("select o from OrderInfo o where " +
            "o.orderState = kr.eddi.ztz_process.entity.order.PaymentState.PAYMENT_CONFIRM or " +
            "o.orderState = kr.eddi.ztz_process.entity.order.PaymentState.WRITE_REVIEW or " +
            "o.orderState = kr.eddi.ztz_process.entity.order.PaymentState.PART_WRITE_REVIEW  or " +
            "o.orderState = kr.eddi.ztz_process.entity.order.PaymentState.ABLE_WRITE_REVIEW ")
    List<OrderInfo> findSalesList();

    @Query("select o from OrderInfo o join fetch o.member join fetch o.product join fetch o.payment where (o.member.id =:memberId) and (o.orderState =:PAYMENT_CONFIRM or o.orderState =:REFUND_REQUEST)")
    List<OrderInfo> findByPaymentState(PaymentState PAYMENT_CONFIRM,PaymentState REFUND_REQUEST, Long memberId);

    @Query("select o from OrderInfo o join fetch o.payment join fetch o.member join fetch o.product op where op.productNo = :productNo")
    List<OrderInfo> findByProductNo(Long productNo);
}
