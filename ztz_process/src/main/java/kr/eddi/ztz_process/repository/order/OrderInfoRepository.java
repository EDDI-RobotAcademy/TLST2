package kr.eddi.ztz_process.repository.order;

import kr.eddi.ztz_process.entity.order.OrderInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface OrderInfoRepository extends JpaRepository<OrderInfo, Long> {
    @Query("select o from OrderInfo o where o.orderNo = :orderNo")
    Optional<OrderInfo> findByOrderNo(String orderNo);

    @Query("select o from OrderInfo o where o.payment.paymentId = :paymentId")
    List<OrderInfo> findByPaymentId(Long paymentId);

    @Query("select o from OrderInfo o join fetch o.member where o.member.id = :memberId")
    List<OrderInfo> findByMemberId(Long memberId);
}
