package kr.eddi.ztz_process;


import kr.eddi.ztz_process.entity.tour.Foundry;
import kr.eddi.ztz_process.entity.tour.MapPoint;
import kr.eddi.ztz_process.repository.tour.FoundryRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.web.WebAppConfiguration;

@SpringBootTest
@WebAppConfiguration
public class ReservationTestCase {

    @Autowired
    FoundryRepository repository;

    @Test
    void saveFoundryInformation() {

        MapPoint mp1 = new MapPoint(37.9058024 , 127.3088802);
        MapPoint mp2 = new MapPoint(36.9970372 , 127.8787317);
        MapPoint mp3 = new MapPoint(36.678079 , 127.480009);
        MapPoint mp4 = new MapPoint(35.3451059 , 126.8128224);
        MapPoint mp5 = new MapPoint(36.7722669 , 128.3138075);
        MapPoint mp6 = new MapPoint(36.7722669 , 126.3375372);


        Foundry foundry1 = new Foundry(
                "산사원",
                "경기도 포천시 화현면 화현리 512",
                "031-531-9300",
                "박물관 투어",
                1, 1, 3500,
                mp1
        );

        Foundry foundry2 = new Foundry(
                "중원당",
                "충주시 감금면 창동리 243",
                "043 842 5005",
                "전통주 체험",
                4, 2, 40000,
                mp2

        );
        Foundry foundry3 = new Foundry(
                "좋은술세종",
                "청주시 청원구 사천로 19번길 5-2",
                "043 218 7688",
                "단양주 빚기",
                10, 2, 25000,
                mp3
        );
        Foundry foundry4 = new Foundry(
                "청산녹수",
                "전남 장성군 장성읍 남양촌길 19",
                "061 393 4141",
                "양조장 견학, 소개 및 시음",
                1, 1, 20000,
                mp4
        );
        Foundry foundry5 = new Foundry(
                "문경주조",
                "경상북도 문경시 동로면 노은리 192",
                "054 552 8252",
                "양조장 투어 및 시음",
                12, 2, 20000,
                mp5
        );
        Foundry foundry6 = new Foundry(
                "제주샘주",
                "제주시 애월읍 애원로 283",
                "064 799 4225",
                "제주샘주 칵테일 체험",
                10, 1, 20000,
                mp6

        );

        repository.save(foundry1);
        repository.save(foundry2);
        repository.save(foundry3);
        repository.save(foundry4);
        repository.save(foundry5);
        repository.save(foundry6);
    }


    @Test
    void allReservationListTest(){
        System.out.println("전체예약 리스트 조회:"+repository.findAll());
    }
}
