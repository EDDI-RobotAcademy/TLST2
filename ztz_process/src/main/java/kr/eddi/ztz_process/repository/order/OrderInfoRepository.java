package kr.eddi.ztz_process.repository.order;

import kr.eddi.ztz_process.entity.order.OrderInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface OrderInfoRepository extends JpaRepository<OrderInfo, Long> {
    @Query("select o from OrderInfo o where o.orderID = :orderID")
    List<Optional<OrderInfo>> findByOrderID(Integer orderID);

    @Query("select o from OrderInfo o where o.orderID = :orderID and o.orderedProductName =:orderedProductName")
    Optional<OrderInfo> findProductByIdAndName(Integer orderID,String orderedProductName);
}
