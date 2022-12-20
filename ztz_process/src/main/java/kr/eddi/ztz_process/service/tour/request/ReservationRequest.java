package kr.eddi.ztz_process.service.tour.request;

public record ReservationRequest(
        String username,
        int numberOfMember,
        String reservationDate,
        String phoneNumber,
        String token,
        String foundryName) {

}
