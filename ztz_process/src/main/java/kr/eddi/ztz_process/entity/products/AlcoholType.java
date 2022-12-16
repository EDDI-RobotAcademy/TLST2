package kr.eddi.ztz_process.entity.products;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum AlcoholType {

    TYPE1("소주"), TYPE2("막걸리"), TYPE3("기타");

    final private String type;
    public static AlcoholType ofType(String type){
        return null;
    }

}
