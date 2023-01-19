package kr.eddi.ztz_process.entity.boards;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Data
public class BoardAuthority {

    @Id
    @Column(name = "category_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    private BoardAuthorityType boardAuthorityName;

    public BoardAuthority(BoardAuthorityType boardAuthorityName) {
        this.boardAuthorityName = boardAuthorityName;
    }

}
