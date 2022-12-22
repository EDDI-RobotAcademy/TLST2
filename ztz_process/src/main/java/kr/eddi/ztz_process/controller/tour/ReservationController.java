package kr.eddi.ztz_process.controller.tour;

import kr.eddi.ztz_process.controller.tour.form.ReservationForm;
import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.entity.tour.Foundry;
import kr.eddi.ztz_process.entity.tour.Reservation;
import kr.eddi.ztz_process.service.member.MemberService;
import kr.eddi.ztz_process.service.tour.FoundryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("ztz/tour")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ReservationController {

    @Autowired
    FoundryService foundryservice;


    @GetMapping(path = "/list")
    public List<Foundry> foundryList() {
        return foundryservice.list();
    }

    @PostMapping(path = "/reservation")
    public String reservation(@RequestBody ReservationForm reservationForm) {
        return foundryservice.savedReservation(reservationForm.toReservationRequest());
    }

    @GetMapping(path = "/my-reservation", headers = "Token")
    public List<Reservation> myReservationList(@RequestHeader("Token") String token) {
        return foundryservice.myReservationList(token);
    }

    @DeleteMapping(path = "/{reservationId}", headers = "Token")
    public String cancelMyReservation (@PathVariable("reservationId") Long reservationId, @RequestHeader("Token") String token) {
        return foundryservice.cancelMyReservation(reservationId, token);
    }
}
