package kr.eddi.ztz_process.service.tour.request;

public record ReservationRequest(

        int numberOfMember,
        String reservationDate,
        String contactNumber,
        String token,
        String foundryName) {

}
