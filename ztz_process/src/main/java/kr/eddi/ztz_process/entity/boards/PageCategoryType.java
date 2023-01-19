package kr.eddi.ztz_process.entity.boards;

import lombok.Getter;

@Getter
public enum PageCategoryType {

    PERSONAL_QUESTION("1대1문의"),
    PRODUCT_QUESTION("상품문의");

    private final String pageCategoryType;

    private PageCategoryType(String pageCategoryType) {
        this.pageCategoryType = pageCategoryType;
    }
}
