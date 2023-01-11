package kr.eddi.ztz_process.entity.boards;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
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
