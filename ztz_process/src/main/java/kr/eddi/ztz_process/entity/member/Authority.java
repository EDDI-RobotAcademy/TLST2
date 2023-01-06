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
    private AuthorityType authorityName;

    public Authority(AuthorityType authorityName){
      this.authorityName = authorityName;
    }

    public static Authority ofMember(AuthorityType authorityName) {
      return new Authority(authorityName);
    }





}
