package kr.eddi.ztz_process.repository.order;

//import kr.eddi.ztz_process.controller.products.request.CartListResponse;
import kr.eddi.ztz_process.entity.order.CartItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CartItemRepository extends JpaRepository<CartItem, Long> {
    @Query("select ci from CartItem ci join fetch ci.cart c join fetch ci.product p where c.member.id=:memberId")
    List<CartItem> findCartListByMemberId(Long memberId);
}

//@Query("select ci from CartItem ci join fetch Cart c join fetch Product p where c.member.id=:memberId")
// @Query("select ci from CartItem ci join fetch Cart c join fetch Product p where c.member.id=:memberId")
//ci.cart.member.id=:memberId
//c.member.id=:memberId