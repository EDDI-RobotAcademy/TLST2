package kr.eddi.ztz_process.repository.order;

import kr.eddi.ztz_process.entity.order.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;

public interface PaymentRepository extends JpaRepository<Payment,Long> {
    @Query("select p from Payment p join fetch p.member where p.member.id = :memberId order by p.paymentId desc")
    List<Payment> findAllByMemberId(Long memberId);

    @Query("select p from Payment p join fetch p.member where (p.member.id = :memberId) and (p.regData >= :endData) order by p.paymentId desc")
    List<Payment> findByEndData(@Param("endData")LocalDateTime endData,Long memberId);

    @Query("select p from Payment p join fetch p.member where p.regData >= :endData order by p.paymentId desc")
    List<Payment> findAllByEndData(@Param("endData")LocalDateTime endData);

    @Query("select p from Payment p join fetch p.member order by p.paymentId desc")
    List<Payment> findAllPaymentList();
}
