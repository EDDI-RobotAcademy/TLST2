package kr.eddi.ztz_process.entity.products;

import jakarta.persistence.*;
import kr.eddi.ztz_process.entity.member.Member;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDate;

@Data
@Entity
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long reviewNo;

    @Column(nullable = false)
    private Double rate;

    @Column(nullable = false)
    private String content;

    @Column
    private String thumbnailFileName;

    @CreationTimestamp
    private LocalDate regDate;

    @JoinColumn(name = "member_id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Member member;

    @JoinColumn(name = "product_no")
    @ManyToOne(fetch = FetchType.LAZY)
    private Product product;
}
