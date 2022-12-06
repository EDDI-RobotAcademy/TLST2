package kr.eddi.ztz_process.entity.products;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.Arrays;

@Getter
@RequiredArgsConstructor
public enum Local {

    LOCO1("서울경기"),LOCO2("강원"),LOCO3("전라"),LOCO4("충청"),LOCO5("경상"),LOCO6("제주");

    private final String local;

    public static Local ofType(String local){
        return null;
    }

    public static Local valueOfLocalName(String local) {
        return Arrays.stream(values())
                .filter(value -> value.local.equals(local))
                .findAny()
                .orElse(null);
    }

    public static Local of(String local) {
        return Local.valueOf(local);
    }

}
