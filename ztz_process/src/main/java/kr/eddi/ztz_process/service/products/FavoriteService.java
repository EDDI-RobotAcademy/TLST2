package kr.eddi.ztz_process.service.products;

import kr.eddi.ztz_process.controller.products.response.FavoriteResponse;

public interface FavoriteService {
    public FavoriteResponse favoriteStatus(Long memberId, Long productNo, String favoriteType);
}
