package kr.eddi.ztz_process.entity.products;

import jakarta.persistence.*;
import kr.eddi.ztz_process.entity.member.Member;
import lombok.*;


@Setter
@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Favorite {

    @Id
    @Getter
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id", nullable = false)
    private Member member;

    @Getter
    @Column(nullable = false)
    private boolean likeFlag = false;

    public boolean getLikeFlag() {
        return likeFlag;
    }

}
