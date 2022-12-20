package kr.eddi.ztz_process.controller.tour.form;

import kr.eddi.ztz_process.service.tour.request.ReservationRequest;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ReservationForm {
    private String username;
    private int numberOfMember;
    private String reservationDate;
    private String phoneNumber;
    private String token;
    private int foundryId;


    public ReservationRequest toReservationRequest(){
        return new ReservationRequest(username,numberOfMember,reservationDate,phoneNumber,token,foundryId);
    }
}
