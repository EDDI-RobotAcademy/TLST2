package kr.eddi.ztz_process.service.tour;

import kr.eddi.ztz_process.entity.tour.Foundry;
import kr.eddi.ztz_process.entity.tour.Reservation;
import kr.eddi.ztz_process.service.tour.request.PaymentReservationRequest;
import kr.eddi.ztz_process.service.tour.request.ReservationRequest;

import java.util.List;

public interface FoundryService {
    List<Foundry> list();
    String savedReservation(ReservationRequest reservationRequest);
    List<Reservation> myReservationList(String token);
    String cancelMyReservation(Long reservationId, String token);
    String modifyMyReservation(Long reservationId, ReservationRequest reservationRequest);
    List<Reservation> allReservationList();
    String saveMyReservationPaymentDetail(PaymentReservationRequest paymentReservationRequest);

}
