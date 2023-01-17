package kr.eddi.ztz_process.entity.search;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;
import kr.eddi.ztz_process.entity.member.Member;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;


@Data
@Entity
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class Keyword {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long keywordNo;

    @Column(nullable = false)
    private String keyword;

    @Column(nullable = false)
    private Integer searchedCnt;

    @CreationTimestamp
    private LocalDate regDate;

    @UpdateTimestamp
    private LocalDate upDate;
}
