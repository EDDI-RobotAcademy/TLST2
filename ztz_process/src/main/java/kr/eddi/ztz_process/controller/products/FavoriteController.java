package kr.eddi.ztz_process.controller.products;

import kr.eddi.ztz_process.controller.member.form.MemberLoggedInTokenForm;
import kr.eddi.ztz_process.controller.products.request.FavoriteInfo;
import kr.eddi.ztz_process.controller.products.response.FavoriteResponse;
import kr.eddi.ztz_process.entity.products.Favorite;
import kr.eddi.ztz_process.service.products.FavoriteService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("ztz/products/favorite")
@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")
public class FavoriteController {

    @Autowired
    private FavoriteService service;

    @PostMapping("/changeFavoriteStatus")
    public FavoriteResponse productFavoriteStatus (@RequestBody FavoriteInfo favoriteInfo) {
        log.info("좋아요 메소드 실행- 상품번호: "+ favoriteInfo.getProductNo());
        Long memberId = favoriteInfo.getMemberId();
        Long boardNo = favoriteInfo.getProductNo();
        String favoriteType = favoriteInfo.getFavoriteType();

        return service.favoriteStatus(memberId, boardNo, favoriteType);
    }

    @PostMapping("/myFavorite")
    public List<Favorite> myFavoriteProductList (@RequestBody MemberLoggedInTokenForm memberLoggedInTokenForm) {
        log.info("찜한 상품- 멤버 아이디: "+ memberLoggedInTokenForm.getToken());

        return service.myFavoriteProductList(memberLoggedInTokenForm.getToken());
    }
}
