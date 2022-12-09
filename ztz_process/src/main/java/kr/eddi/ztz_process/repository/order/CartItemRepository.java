package kr.eddi.ztz_process.repository.order;

import kr.eddi.ztz_process.entity.order.CartItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CartItemRepository extends JpaRepository<CartItem, Long> {

    @Query("select ci from CartItem ci join Cart c where ci.cart.member.id = :memberId")
    List<CartItem> findCartListByMemberId(Long memberId);

}
