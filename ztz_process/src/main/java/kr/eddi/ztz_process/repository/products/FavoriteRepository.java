package kr.eddi.ztz_process.repository.products;

import kr.eddi.ztz_process.entity.products.Favorite;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;


public interface FavoriteRepository extends JpaRepository<Favorite, Long> {

    @Query("select f from Favorite f join fetch f.product fp join fetch f.member fm where fp.productNo = :product_no and fm.id= :member_id")
    Optional<Favorite> findByProductAndMember(Long product_no, Long member_id);

    @Query("select f from Favorite f join fetch f.product fp where fp.productNo = :product_no")
    List<Favorite> findAllFavoriteByProductNo(Long product_no);

    @Query("select f from Favorite f join fetch f.product fp  join fetch f.member fm where fm.id= :member_id and f.likeFlag = true" )
    List<Favorite> findByFavoriteByMemberId(Long member_id);
}