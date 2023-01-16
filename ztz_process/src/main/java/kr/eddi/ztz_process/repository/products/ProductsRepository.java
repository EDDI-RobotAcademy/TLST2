package kr.eddi.ztz_process.repository.products;

import kr.eddi.ztz_process.entity.products.AlcoholType;
import kr.eddi.ztz_process.entity.products.Local;
import kr.eddi.ztz_process.entity.products.Product;
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

}
