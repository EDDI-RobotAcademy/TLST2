package kr.eddi.ztz_process.repository.order;

import kr.eddi.ztz_process.entity.order.CartItem;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CartItemRepository extends JpaRepository<CartItem, Long> {


}
