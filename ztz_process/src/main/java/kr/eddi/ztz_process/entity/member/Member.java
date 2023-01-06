package kr.eddi.ztz_process.entity.member;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

@Entity
@NoArgsConstructor
public class Member {

    @Id
    @Getter
    @Column(name = "member_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Getter
    @Column(nullable = false)
    private String email;

    @Getter
    @Column(nullable = false)
    private String username;

    @Getter
    @Column(nullable = false)
    private int birthdate;

    @Getter
    @Column
    private boolean managerCheck;

    @Getter
    @JsonIgnore
    @JoinColumn(name ="authority_id")
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private Authority authority;

    @OneToMany(mappedBy = "member", fetch = FetchType.LAZY, orphanRemoval = true)
    private Set<Authentication> authentications = new HashSet<>();

    @OneToOne(mappedBy = "member", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST , orphanRemoval = true)
    private MemberProfile profile;

    public Member(String email, String username, int birthdate, Authority authority, boolean managerCheck, MemberProfile memberProfile) {
        this.email = email;
        this.username = username;
        this.birthdate = birthdate;
        this.authority = authority;
        this.managerCheck = managerCheck;
        this.profile = memberProfile;
        memberProfile.setMember(this);
    }

    public Member(String email, String username, int birthdate, Authority authority, boolean managerCheck) {
        this.email = email;
        this.username = username;
        this.birthdate = birthdate;
        this.authority = authority;
        this.managerCheck = managerCheck;
    }


    public boolean isRightPassword(String plainToCheck) {
        final Optional<Authentication> maybeBasicAuth = findBasicAuthentication();

        if (maybeBasicAuth.isPresent()) {
            final BasicAuthentication auth = (BasicAuthentication) maybeBasicAuth.get();
            return auth.isRightPassword(plainToCheck);
        }

        return false;
    }

    private Optional<Authentication> findBasicAuthentication() {
        return authentications
                .stream()
                .filter(auth -> auth instanceof BasicAuthentication)
                .findFirst();
    }
}
