package kr.eddi.ztz_process.repository.order;

import kr.eddi.ztz_process.entity.order.OrderInfo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderInfoRepository extends JpaRepository<OrderInfo, Long> {

}
