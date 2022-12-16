package kr.eddi.ztz_process.controller.order;

import lombok.Builder;

@Builder
public class ResponseOrderInfo {

    private String productName;

    private Integer productPrice;

    private Integer productCnt;

    private String productThumbnailRoute;
    //private MemberAddress memberAddress;

    public ResponseOrderInfo(String productName , Integer productPrice, Integer productCnt,String productThumbnailRoute){
        this.productName = productName;
        this.productCnt = productCnt;
        this.productPrice = productPrice;
        this.productThumbnailRoute = productThumbnailRoute;
    }
}
