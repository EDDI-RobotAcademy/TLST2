package kr.eddi.ztz_process.controller.tour.form;

import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.service.tour.request.ReservationRequest;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ReservationForm {

    private int numberOfMember;
    private String reservationDate;
    private String contactNumber;
    private String token;
    private String foundryName;


    public ReservationRequest toReservationRequest(){
        return new ReservationRequest(numberOfMember,reservationDate,contactNumber,token,foundryName);
    }
}
