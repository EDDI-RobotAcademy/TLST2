package kr.eddi.ztz_process.utility;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;
import kr.eddi.ztz_process.entity.products.AlcoholType;

@Converter
public class alcoholTypeConverter implements AttributeConverter<AlcoholType, String> {
    @Override
    public String convertToDatabaseColumn(AlcoholType attribute) {
        if(attribute == null) {
            throw new IllegalArgumentException("주종 입력이 되지 않았습니다.");
        }
        return attribute.getType();
    }

    @Override
    public AlcoholType convertToEntityAttribute(String dbData) {
        if(dbData == null || dbData.isBlank()) {
            throw new IllegalArgumentException("dbData가 비어있습니다.");
        }
        return AlcoholType.ofType(dbData);
    }
}
