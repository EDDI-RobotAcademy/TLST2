package kr.eddi.ztz_process.repository.order;


import kr.eddi.ztz_process.entity.order.Item;
import kr.eddi.ztz_process.entity.products.AlcoholType;
import kr.eddi.ztz_process.entity.products.Local;
import kr.eddi.ztz_process.entity.products.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;


public interface ItemRepository extends JpaRepository<Item, Long>{

    @Query("select i from Item i join fetch i.cart c join fetch i.product p where c.member.id=:memberId")
    List<Item> findCartListByMemberId(Long memberId);
    @Query("select i from Item i join fetch i.cart c join fetch i.product p where i.itemNo = :itemNo")
    Item findItemByItemNo (Long itemNo);

}

