package kr.eddi.ztz_process.entity.member;

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

    @OneToMany(mappedBy = "member", fetch = FetchType.LAZY, orphanRemoval = true)
    private Set<Authentication> authentications = new HashSet<>();

    public Member(String email, String username, int birthdate) {
        this.email = email;
        this.username = username;
        this.birthdate = birthdate;
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
