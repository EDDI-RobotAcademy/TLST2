package kr.eddi.ztz_process;

import kr.eddi.ztz_process.entity.products.*;
import kr.eddi.ztz_process.repository.products.ProductsRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
@SpringBootTest
public class ProductsListTest {

    @Autowired
    ProductsRepository repository;

    @Test
    public void saveProduct () {
        String brand = "테스트 양조장";
        String name = "이화주";
        Long price = 28000L;
        Classification cls = new Classification(AlcoholType.TYPE3, Local.LOCO6);
        ProductInfo pi = new ProductInfo("pd_01.png");

        //String brand, String name, Long price, Classification classification,ProductInfo productInfo
        Product product = new Product(
                brand,
                name,
                price,
                cls,
                pi
        );

        Product product2 = new Product(
                "광주요",
                "화요 25",
                15000L,
                cls,
                pi
        );

        repository.save(product);
        repository.save(product2);

    }
}
