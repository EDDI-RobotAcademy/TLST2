package kr.eddi.ztz_process.entity.member;

import jakarta.persistence.Column;
import jakarta.persistence.Convert;
import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import kr.eddi.ztz_process.utility.encrypt.EncryptionUtil;
import kr.eddi.ztz_process.utility.password.PasswordHashConverter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Entity
@ToString(callSuper = true)
@NoArgsConstructor
@DiscriminatorValue(Authentication.BASIC_AUTH)
public class BasicAuthentication extends Authentication {

    @Setter
    @Column(nullable = false)
    @Convert(converter = PasswordHashConverter.class)
    private String password;

    public BasicAuthentication(Member member, String authenticationType, String password) {
        super(member, authenticationType);
        this.password = password;
    }

    public boolean isRightPassword(String plainToCheck) {
        return EncryptionUtil.checkValidation(plainToCheck, password);
    }
}
