package kr.eddi.ztz_process.service.tour;

import kr.eddi.ztz_process.entity.tour.Foundry;
import kr.eddi.ztz_process.service.tour.request.ReservationRequest;

import java.util.List;

public interface FoundryService {
    List<Foundry> list();
    String savedReservation(ReservationRequest reservationRequest);
}
