package kr.eddi.ztz_process.entity.boards;

import jakarta.persistence.*;
import kr.eddi.ztz_process.entity.member.Member;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Data
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class QuestionBoard {
    @Id
    @Getter
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long questionNo;

    @JoinColumn(name = "category_id")
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private BoardCategory boardCategory;

    @Column(length = 128, nullable = false)
    private String title;

    @Lob
    private String content;

    @Column
    private String answerState = "답변대기";

    @Column(nullable = false, columnDefinition = "TINYINT(1)")
    private Boolean privateCheck;

    @JoinColumn(name = "member_id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Member member;

    @CreationTimestamp
    @DateTimeFormat(pattern = "yyyy-mm-dd")
    private LocalDate createDateTime;

    @UpdateTimestamp
    @DateTimeFormat(pattern = "yyyy-mm-dd")
    private LocalDate upDateTime;

    @PrePersist
    public void createDate(){
        this.createDateTime = LocalDate.now();
        this.upDateTime = LocalDate.now();
    }
}
