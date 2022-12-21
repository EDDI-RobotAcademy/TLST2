package kr.eddi.ztz_process.entity.member;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@AllArgsConstructor
public class Authority {

    @Id
    @Getter
    @Column(name = "authority_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Getter
    @Column(nullable = true)
    private Long authorityNo;

    @Getter
    @Column(nullable = true)
    private String authorityName;

    public Authority(Long authorityNo, String authorityName){
        this.authorityNo = authorityNo;
        this.authorityName = authorityName;
    }

    public static Authority ofMember(Long authorityId, String authorityName) {
        return new Authority(authorityId, authorityName);
    }

}
