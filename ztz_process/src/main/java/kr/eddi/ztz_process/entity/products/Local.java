package kr.eddi.ztz_process.entity.products;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.Arrays;

@Getter
@RequiredArgsConstructor
public enum Local {


    SEOUL_GYEONGGI("서울경기"),GANGWON("강원"),JEONLA("전라"),CHUNGCHEONG("충청"),GYEONGSANG("경상"),JEJU("제주");


    private final String local;

    public static Local valueOfLocalName(String local) {
        return Arrays.stream(values())
                .filter(value -> value.local.equals(local))
                .findAny()
                .orElse(null);
    }

}
