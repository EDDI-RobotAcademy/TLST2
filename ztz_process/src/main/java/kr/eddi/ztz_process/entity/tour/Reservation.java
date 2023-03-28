package kr.eddi.ztz_process.entity.tour;

import jakarta.persistence.*;
import kr.eddi.ztz_process.entity.member.Member;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Data
@Entity
@RequiredArgsConstructor
public class Reservation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ReservationId;
    @ManyToOne
    @JoinColumn(name = "Member_id")
    private Member member;
    @Column(nullable = false)
    private String contactNumber;
    @DateTimeFormat(pattern = "yyyy-mm-dd")
    private LocalDate reservationDate;
    @Column(nullable = false)
    private int numberOfMember;
    @ManyToOne
    @JoinColumn(name = "Foundry_id")
    private Foundry foundry;
    @Embedded
    private PaymentReservation paymentReservation;

    public Reservation(Member member, String contactNumber, LocalDate reservationDate, int numberOfMember, Foundry foundry) {
        this.member = member;
        this.contactNumber = contactNumber;
        this.reservationDate = reservationDate;
        this.numberOfMember = numberOfMember;
        this.foundry = foundry;
        this.paymentReservation = new PaymentReservation();
    }

}
