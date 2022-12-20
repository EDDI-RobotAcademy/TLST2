package kr.eddi.ztz_process.service.tour;

import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.entity.tour.Foundry;
import kr.eddi.ztz_process.entity.tour.Reservation;
import kr.eddi.ztz_process.repository.member.MemberRepository;
import kr.eddi.ztz_process.repository.tour.FoundryRepository;
import kr.eddi.ztz_process.repository.tour.ReservationRepository;
import kr.eddi.ztz_process.service.security.RedisService;
import kr.eddi.ztz_process.service.tour.request.ReservationRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
@Slf4j
public class FoundryServiceImpl implements FoundryService{

    @Autowired
    FoundryRepository foundryRepository;
    @Autowired
    ReservationRepository reservationRepository;
    @Autowired
    MemberRepository memberRepository;
    @Autowired
    RedisService redisService;


    @Override
    public List<Foundry> list() {
        return foundryRepository.findAll(Sort.by(Sort.Direction.DESC, "foundryId"));
    }

    @Override
    public String savedReservation(ReservationRequest reservationRequest) {
        Long id = redisService.getValueByKey(reservationRequest.token().substring(1, 37));
        Member member = memberRepository.findByMemberId(id);
        Foundry foundry = foundryRepository.findByFoundryId((long)reservationRequest.foundryId());
        LocalDate selectedDate = LocalDate.parse(reservationRequest.reservationDate());

        log.info("받은데이터 : " + reservationRequest.toString());
        Reservation reservation = new Reservation(
                member,
                reservationRequest.username(),
                reservationRequest.phoneNumber(),
                selectedDate,
                reservationRequest.numberOfMember(),
                foundry
        );

        log.info("reservation : " + reservation.toString());
        reservationRepository.save(reservation);

        return "1";
    }
}
