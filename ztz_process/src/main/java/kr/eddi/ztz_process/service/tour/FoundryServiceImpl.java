package kr.eddi.ztz_process.service.tour;

import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.entity.tour.Foundry;
import kr.eddi.ztz_process.entity.tour.PaymentReservation;
import kr.eddi.ztz_process.entity.tour.Reservation;
import kr.eddi.ztz_process.repository.member.MemberRepository;
import kr.eddi.ztz_process.repository.tour.FoundryRepository;
import kr.eddi.ztz_process.repository.tour.ReservationRepository;
import kr.eddi.ztz_process.service.security.RedisService;
import kr.eddi.ztz_process.service.tour.request.PaymentReservationRequest;
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
    public List<Reservation> myReservationList(String token) {
        String SubString = "";
        if(token.length() >= 37){
            SubString = token.substring(1,37);
        }else {
            SubString = token;
        }
        Long id = redisService.getValueByKey(SubString);
        Member member = memberRepository.findByMemberId(id);
        return reservationRepository.findByMember(member);
    }

    @Override
    public String savedReservation(ReservationRequest reservationRequest) {
        String SubString = "";
        if(reservationRequest.token().length() >= 37){
            SubString = reservationRequest.token().substring(1,37);
        }else {
            SubString = reservationRequest.token();
        }
        Long id = redisService.getValueByKey(SubString);
        Member member = memberRepository.findByMemberId(id);
        Foundry foundry = foundryRepository.findByFoundryName(reservationRequest.foundryName());
        LocalDate selectedDate = LocalDate.parse(reservationRequest.reservationDate());

        Reservation reservation = new Reservation(
                member,
                reservationRequest.contactNumber(),
                selectedDate,
                reservationRequest.numberOfMember(),
                foundry
        );

        reservationRepository.save(reservation);
        return "1";
    }

    @Override
    public String cancelMyReservation(Long reservationId, String token) {
        String SubString = "";
        if(token.length() >= 37){
            SubString = token.substring(1,37);
        }else {
            SubString = token;
        }
        Long userId = redisService.getValueByKey(SubString);
        Reservation reservation = reservationRepository.findByReservationId(reservationId);
        Long reservationPersonId = reservation.getMember().getId();

        //토큰으로 찾은 내 아이디와 예약번호로 찾은 예약의 사용자와 동일한지 확인
        if(userId == reservationPersonId) {
            reservationRepository.deleteById(reservationId);
            return "1";
        }

        return "-1";
    }

    @Override
    public String modifyMyReservation(Long reservationId, ReservationRequest reservationRequest) {
        String SubString = "";
        if(reservationRequest.token().length() >= 37){
            SubString = reservationRequest.token().substring(1,37);
        }else {
            SubString = reservationRequest.token();
        }
        Long id = redisService.getValueByKey(SubString);
        Reservation reservation = reservationRepository.findByReservationId(reservationId);
        LocalDate selectedDate = LocalDate.parse(reservationRequest.reservationDate());

        if(reservation.getMember().getId() == id) {
            reservation.setContactNumber(reservationRequest.contactNumber());
            reservation.setNumberOfMember(reservationRequest.numberOfMember());
            reservation.setReservationDate(selectedDate);
            reservationRepository.save(reservation);
            return "1";
        }

        return "-1";
    }

    @Override
    public List<Reservation> allReservationList() {
        return reservationRepository.findAll();
    }

    @Override
    public String saveMyReservationPaymentDetail(PaymentReservationRequest paymentReservationRequest) {
        Reservation reservation = reservationRepository.findByReservationId(paymentReservationRequest.reservationId());

        //결제한 예약건의 사용자와 전달받은 사용자 아이디가 동일하면,
        if(paymentReservationRequest.memberId() == reservation.getMember().getId()) {

            PaymentReservation paymentReservation = new PaymentReservation(
                    paymentReservationRequest.merchant_uid(),
                    paymentReservationRequest.totalPaymentPrice(),
                    paymentReservationRequest.paymentState()
            );

            reservation.setPaymentReservation(paymentReservation);
            log.info(reservation.getPaymentReservation().toString());
            reservationRepository.save(reservation);
            return "1";
        }

        return "-1";
    }
}
