package kr.eddi.ztz_process.repository.products;

import kr.eddi.ztz_process.entity.products.AlcoholType;
import kr.eddi.ztz_process.entity.products.Local;
import kr.eddi.ztz_process.entity.products.Product;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;


public interface ProductsRepository extends JpaRepository<Product, Long> {
    @Query("select p from Product p where p.classification.local = :local")
    List<Product> filterLoco(Local local);

    @Query("select p from Product p where p.classification.alcoholType = :alcoholType")
    List<Product> filterType(AlcoholType alcoholType);

    @Query("select p from Product p where p.name like %:name% or p.brand like %:brand% order by p.productNo desc")
    List<Product> findSearchProduct(String name, String brand);

    @Query("select p from Product p where p.monthAlcoholCheck = true order by p.productNo desc")
    List<Product> findMonthAlcoholProducts();

    @Query("select p from Product p where p.classification.alcoholType =:alcohol_type and p.classification.local =:local")
    List<Product> findByLocalAndType(AlcoholType alcohol_type , Local local);

    @Query("select p from Product p where p.productNo = :productNo")
    Product findProductByProductNo(Long productNo);

    @Query("select p from Product p where p.monthAlcoholCheck = true and p.classification.local = :local")
    List<Product> findMonthByLocal(Local local);

    @Query("select p from Product p where p.classification.local = :local order by p.view desc ")
    List<Product> findBestByLocal(Local local);

    @Query("select p from Product p where p.classification.alcoholType =:alcohol_type and p.classification.local =:local order by p.view desc")
    List<Product> findBestByLocalAndType(AlcoholType alcohol_type , Local local);

    @Query("select p from Product p where p.classification.alcoholType = :alcoholType order by p.view desc ")
    List<Product> findBestByAlcoholType(AlcoholType alcoholType);

    @Query("select p from Product p where p.classification.local = :local order by p.favoriteNum desc ")
    List<Product> findFavoriteByLocal(Local local);




    // 페이지 처리
    @Query("select p from Product p order by p.productNo desc ")
    List<Product> firstProducts(Pageable pageable);

    @Query("select p from Product p where p.productNo < :productNo order by p.productNo desc ")
    List<Product> nextProducts( Pageable pageable , Long productNo);

    @Query("select p from Product p where p.classification.local = :local order by p.productNo desc ")
    List<Product> filterLocalFirstItems(Local local, Pageable pageable);

    @Query("select p from Product p where p.classification.local = :local and p.productNo < :productNo order by p.productNo desc ")
    List<Product> filterLocalNextItems(Local local, Pageable pageable , Long productNo);

    @Query("select p from Product p where p.classification.alcoholType = :alcoholType order by p.productNo desc")
    List<Product> filterTypeFirstItems(AlcoholType alcoholType, Pageable pageable);

    @Query("select p from Product p where p.classification.alcoholType = :alcoholType and p.productNo < :productNo order by p.productNo desc")
    List<Product> filterTypeNextItems(AlcoholType alcoholType, Pageable pageable, Long productNo);

    @Query("select p from Product p where p.name like %:name% or p.brand like %:brand% order by p.productNo desc")
    List<Product> findSearchFirstItems(String name, String brand, Pageable pageable);

    @Query("select p from Product p where p.name like %:name% or p.brand like %:brand% and p.productNo < :productNo order by p.productNo desc")
    List<Product> findSearchNextItems(String name, String brand, Pageable pageable, Long productNo);

    @Query("select p from Product p where p.classification.alcoholType =:alcohol_type and p.classification.local =:local order by p.productNo desc")
    List<Product> findByLocalAndTypeFirstItems(AlcoholType alcohol_type , Local local, Pageable pageable);

    @Query("select p from Product p where p.classification.alcoholType =:alcohol_type and p.classification.local =:local and p.productNo < :productNo order by p.productNo desc")
    List<Product> findByLocalAndTypeNextItems(AlcoholType alcohol_type , Local local, Pageable pageable, Long productNo);


    @Query("select p from Product p where p.classification.alcoholType =:alcohol_type and p.classification.local =:local order by p.favoriteNum desc")
    List<Product> findFavoriteByLocalAndType(AlcoholType alcohol_type , Local local);

    @Query("select p from Product p where p.classification.alcoholType = :alcoholType order by p.favoriteNum desc ")
    List<Product> findFavoriteByAlcoholType(AlcoholType alcoholType);
}
