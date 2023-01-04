package kr.eddi.ztz_process.entity.tour;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@Embeddable
@NoArgsConstructor
public class Foundry {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long foundryId;

    @Column(nullable = false)
    private String name;
    @Column(nullable = false)
    private String address;
    @Column(nullable = false)
    private String tel;

    @Column
    private String imgName;

    @Embedded
    private MapPoint mapPoint;

    @Column(nullable = false)
    private int minMember;
    @Column(nullable = false)
    private int durationOfTime;
    @Column(nullable = false)
    private int price;
    @Column(nullable = false)
    private String content;

    public Foundry (
            String name,
            String address,
            String tel,
            String content,
            String imgName,
            int minMember,
            int durationOfTime,
            int price,
            MapPoint mapPoint

    ) {
        this.name = name;
        this.address = address;
        this.tel = tel;
        this.content = content;
        this.imgName = imgName;
        this.minMember = minMember;
        this.durationOfTime = durationOfTime;
        this.price = price;
        this.mapPoint = mapPoint;

    }

}
