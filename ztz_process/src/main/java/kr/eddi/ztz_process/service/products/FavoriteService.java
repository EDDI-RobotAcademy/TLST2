package kr.eddi.ztz_process.service.products;

import kr.eddi.ztz_process.controller.products.response.FavoriteResponse;
import kr.eddi.ztz_process.entity.products.Favorite;

import java.util.List;

public interface FavoriteService {
    public FavoriteResponse favoriteStatus(Long memberId, Long productNo, String favoriteType);

    public List<Favorite> myFavoriteProductList(String token);



}
