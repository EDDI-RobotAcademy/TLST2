package kr.eddi.ztz_process;

import kr.eddi.ztz_process.controller.products.response.FavoriteResponse;
import kr.eddi.ztz_process.service.products.FavoriteService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class FavoriteTestCase {

    @Autowired
    FavoriteService favoriteService;


    @Test
    void saveFavoriteTest() {
        Long memberId = 3L;
        Long productNo = 1l;
        String favoriteType = "favoriteLike";

        FavoriteResponse favoriteResponse = favoriteService.favoriteStatus(memberId, productNo,favoriteType);
        System.out.println("상품 찜 결과: " + favoriteResponse.getFavoriteNum());
    }

    @Test
    void checkFavoriteTest() {
        Long memberId = 3L;
        Long productNo = 1l;
        String favoriteType = "favoriteCheck";

        FavoriteResponse favoriteResponse = favoriteService.favoriteStatus(memberId, productNo,favoriteType);
        System.out.println("상품 찜 조회 결과: " + favoriteResponse.getProductFavoriteFlag());
    }
}