package kr.eddi.ztz_process.entity.member;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@Entity
@AllArgsConstructor
@NoArgsConstructor
public class MemberProfile {

    @Id
    @Column(name = "member_profile_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id = null;

    @Column(nullable = false)
    private String PhoneNumber;

    @Embedded
    private Address address;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    private MemberProfile(Address address, String phoneNumber) {
        this.address = address;
        this.PhoneNumber = phoneNumber;
    }

    public static MemberProfile of (String city, String street, String addressDetail, String zipcode,String phoneNumber) {
        final Address address = Address.of(city, street, addressDetail, zipcode);
        return new MemberProfile(address , phoneNumber);
    }

    public void setMember (Member member) {
        this.member = member;
    }
}
