package kr.eddi.ztz_process.entity.member;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;


@Getter
@Embeddable
@NoArgsConstructor
@AllArgsConstructor
public class Address {

    @Column(nullable = false)
    private String city;

    @Column(nullable = false)
    private String street;

    @Column(nullable = false)
    private String addressDetail;

    @Column(nullable = false)
    private String zipcode;

    public static Address of(String city, String street, String addressDetail, String zipcode) {
        return new Address(city, street, addressDetail, zipcode);
    }
}
