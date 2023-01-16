package kr.eddi.ztz_process.entity.search;

import jakarta.persistence.*;
import lombok.Data;
import lombok.RequiredArgsConstructor;


@Data
@Entity
@RequiredArgsConstructor
public class RecommendedKeywords {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long recommendedId;

    @Column(nullable = false)
    private String recommendedKeyword;

    private boolean isSelected = false;

    public RecommendedKeywords(String recommendedKeyword){
        this.recommendedKeyword = recommendedKeyword;
    }

}
