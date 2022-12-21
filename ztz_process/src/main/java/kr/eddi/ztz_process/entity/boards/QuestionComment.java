package kr.eddi.ztz_process.entity.boards;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.util.Date;

@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class QuestionComment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long questionCommentNo;

    @Column
    private String commentWriter;

    @Lob
    private String comment;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_boards_no")
    private QuestionBoard questionBoard;

    @CreationTimestamp
    private Date regDate;

    @UpdateTimestamp
    private Date updDate;
}