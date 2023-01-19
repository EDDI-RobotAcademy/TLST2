package kr.eddi.ztz_process.entity.boards;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import kr.eddi.ztz_process.entity.member.Member;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.time.LocalDateTime;

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

    //1대1 문의, 상품문의 게시판 타입
    @JoinColumn(name = "page_id")
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private PageCategory pageCategory;

    //게시글 내 문의 카테고리
    @JoinColumn(name = "category_id")
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private BoardCategory boardCategory;

    //공개, 비공개 권한
    @JoinColumn(name = "authority_id")
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private BoardAuthority boardAuthority;

    @Column(length = 128, nullable = false)
    private String title;

    @Lob
    private String content;

    @Column
    private String answerState = "답변대기";

    @JsonIgnore
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
