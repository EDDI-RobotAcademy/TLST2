package kr.eddi.ztz_process.repository.products;

import kr.eddi.ztz_process.entity.products.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ReviewRepository extends JpaRepository<Review, Long> {

    @Query("select r from Review r join fetch r.member join fetch r.product p where p.productNo= :productNo")
    List<Review> findByProductNo(Long productNo);

    @Query("select r from Review r join fetch r.product join fetch r.member m where m.id= :memberId")
    List<Review> findByMemberId(Long memberId);

}
