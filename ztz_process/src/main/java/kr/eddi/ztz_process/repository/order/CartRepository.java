package kr.eddi.ztz_process.repository.order;

import kr.eddi.ztz_process.entity.order.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface CartRepository extends JpaRepository<Cart, Long> {

    Optional<Cart> findByMemberId(Long memberId);

}