package kr.eddi.ztz_process.entity.products;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Embeddable
@NoArgsConstructor
public class Classification {

    @Column(name="alcohol_type")
    private AlcoholType alcoholType;

    @Column
    private Local local;


    public Classification(AlcoholType alcoholType, Local local) {
        this.alcoholType = alcoholType;
        this.local = local;
    }

}
