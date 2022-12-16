package kr.eddi.ztz_process.entity.products;

import jakarta.persistence.*;
import kr.eddi.ztz_process.utility.LocalCodeConverter;
import kr.eddi.ztz_process.utility.alcoholTypeConverter;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Embeddable
@NoArgsConstructor
public class Classification {

    @Convert(converter = alcoholTypeConverter.class )
    @Column(name="alcohol_type", nullable = false)
    private AlcoholType alcoholType;

    @Convert(converter = LocalCodeConverter.class )
    @Column(nullable = false)
    private Local local;


    public Classification(AlcoholType alcoholType, Local local) {
        this.alcoholType = alcoholType;
        this.local = local;
    }

}
