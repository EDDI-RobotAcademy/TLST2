package kr.eddi.ztz_process;

import kr.eddi.ztz_process.service.search.SearchService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class SearchTestCase {

    @Autowired
    SearchService service;


    @Test
    void registerTest(){
        for (int i = 0; i < 10; i++) {
            service.registerOrAddCntKeyWord("블루문");
        }
        for (int i = 0; i < 9; i++) {
            service.registerOrAddCntKeyWord("사과");
        }
        for (int i = 0; i < 8; i++) {
            service.registerOrAddCntKeyWord("사과막걸리");
        }
        for (int i = 0; i < 7; i++) {
            service.registerOrAddCntKeyWord("선물세트");
        }
        for (int i = 0; i < 6; i++) {
            service.registerOrAddCntKeyWord("막걸리");
        }
        for (int i = 0; i < 5; i++) {
            service.registerOrAddCntKeyWord("세트");
        }
        for (int i = 0; i < 4; i++) {
            service.registerOrAddCntKeyWord("선물");
        }
        for (int i = 0; i < 3; i++) {
            service.registerOrAddCntKeyWord("양조");
        }

    }

    @Test
    void readTest(){
        service.readTopTenKeyword();
    }
}
