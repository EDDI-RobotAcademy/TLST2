package kr.eddi.ztz_process.repository.tour;

import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.entity.tour.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ReservationRepository  extends JpaRepository<Reservation, Long> {
    @Query("select r from Reservation r where r.member = :member")
    List<Reservation> findByMember(Member member);
}

