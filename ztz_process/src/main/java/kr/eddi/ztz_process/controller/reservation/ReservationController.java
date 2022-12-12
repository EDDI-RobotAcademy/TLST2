package kr.eddi.ztz_process.controller.reservation;

import kr.eddi.ztz_process.entity.reservation.Foundry;
import kr.eddi.ztz_process.service.reservation.FoundryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("ztz/reservation")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ReservationController {

    @Autowired
    FoundryService foundryservice;

    @GetMapping(path = "/list")
    public List<Foundry> foundryList() {
        return foundryservice.list();
    }
}
