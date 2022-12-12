package kr.eddi.ztz_process.repository.order;

import kr.eddi.ztz_process.entity.order.Payment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PaymentRepository extends JpaRepository<Payment,Long> {
}
