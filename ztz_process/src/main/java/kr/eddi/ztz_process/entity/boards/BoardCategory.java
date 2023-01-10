package kr.eddi.ztz_process.entity.boards;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@AllArgsConstructor
public class BoardCategory {

    @Id
    @Column(name = "category_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private BoardCategoryType categoryType;

    public BoardCategory(BoardCategoryType categoryType) {
        this.categoryType = categoryType;
    }

}
