package kr.eddi.ztz_process.service.tour.request;

public record PaymentReservationRequest (
            String merchant_uid,
            Long reservationId,
            Long memberId,
            Integer totalPaymentPrice,
            boolean paymentState) {

    }
