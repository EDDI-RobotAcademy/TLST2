package kr.eddi.ztz_process.service.tour.request;

import kr.eddi.ztz_process.entity.member.Member;

public record ReservationRequest(

        int numberOfMember,
        String reservationDate,
        String contactNumber,
        String token,
        String foundryName) {

}
