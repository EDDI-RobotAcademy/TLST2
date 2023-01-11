package kr.eddi.ztz_process.entity.boards;

import jakarta.persistence.*;
import lombok.*;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Data
public class BoardCategory {

    @Id
    @Column(name = "category_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    private BoardCategoryType categoryType;

    public BoardCategory(BoardCategoryType categoryType) {
        this.categoryType = categoryType;
    }

}
