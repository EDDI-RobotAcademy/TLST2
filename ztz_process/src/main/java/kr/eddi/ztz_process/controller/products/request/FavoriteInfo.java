package kr.eddi.ztz_process.controller.products.request;

import lombok.Getter;

@Getter
public class FavoriteInfo {
    private Long memberId;
    private Long productNo;
    private String favoriteType;
}
