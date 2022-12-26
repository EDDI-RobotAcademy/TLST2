package kr.eddi.ztz_process.repository.order;

import kr.eddi.ztz_process.entity.order.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface PaymentRepository extends JpaRepository<Payment,Long> {
    @Query("select p from Payment p join fetch p.member where p.member.id = :memberId order by p.paymentId desc")
    List<Payment> findAllByMemberId(Long memberId);

}
