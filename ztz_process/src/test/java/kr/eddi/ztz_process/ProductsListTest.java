package kr.eddi.ztz_process;

import kr.eddi.ztz_process.entity.products.*;
import kr.eddi.ztz_process.repository.products.ProductsRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@SpringBootTest
public class ProductsListTest {

    @Autowired
    ProductsRepository repository;

    @Test
    public void saveProduct () {
        String brand = "진리";
        String name = "화요";
        int price = 70000;
        int deliveryFee = 0;
        Classification cls1 = new Classification(AlcoholType.SOJU_SPIRITS, Local.SEOUL_GYEONGGI);

        List<String> images = new ArrayList<>();
        images.add("pd_01.png");

        List<String> taste = new ArrayList<>();
        taste.add("달달");
        ProductInfo pi1 = new ProductInfo("pd_01.png", images, taste, "달달하고 시원한 맛!", "배송비 무료이벤트 적용 상품입니다");

        Product product = new Product(
                brand,
                name,
                price,
                deliveryFee,
                cls1,
                pi1
        );

        repository.save(product);

    }

    @Test
    public void modifyProduct () {
        Long productNo = 4L;
        Optional<Product> maybeProduct = repository.findById(productNo);
        Product product = maybeProduct.get();

        product.setName("영덕의 밤");
        product.setBrand("영덕법인");
        product.setPrice(37000);
        product.setDeliveryFee(0);
        repository.save(product);
    }

    @Test
    public void deleteProduct(){
        Long productNo = 4L;
        repository.deleteById(productNo);
    }

    @Test
    public void findAlcocholProduct(){
        String tmp = "소주증류주";
        AlcoholType filterAlcohol = AlcoholType.valueOfAlcoholName(tmp);
        System.out.println("소주증류주 찾기"+ repository.filterType(filterAlcohol));
    }
}
