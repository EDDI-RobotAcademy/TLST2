package kr.eddi.ztz_process.entity.order;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;
import kr.eddi.ztz_process.entity.member.Address;
import kr.eddi.ztz_process.entity.member.Member;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;
import java.util.*;
import java.util.regex.Pattern;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long paymentId;

    @Column(nullable = false)
    private Integer totalPaymentPrice;

    @Column(nullable = false)
    private String merchant_uid;

    @Column(nullable = false)
    private String imp_uid;

    @Column(nullable = false)
    private Integer OrderedCnt;

    @Column(nullable = false)
    private String PaymentState;

    @Column(nullable = false)
    private String DeliveryRequest;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private Member member;

    @Getter
    @Embedded
    private Address address;

    @CreationTimestamp
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
    private LocalDateTime regData = LocalDateTime.now();

    @UpdateTimestamp
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
    private LocalDateTime updData = LocalDateTime.now();

}
