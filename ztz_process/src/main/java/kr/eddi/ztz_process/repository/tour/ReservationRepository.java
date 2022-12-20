package kr.eddi.ztz_process.repository.tour;

import kr.eddi.ztz_process.entity.tour.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReservationRepository  extends JpaRepository<Reservation, Long> {

}

