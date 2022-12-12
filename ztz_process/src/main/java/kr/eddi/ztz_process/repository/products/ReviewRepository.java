package kr.eddi.ztz_process.repository.products;

import kr.eddi.ztz_process.entity.products.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ReviewRepository extends JpaRepository<Review, Long> {
}
