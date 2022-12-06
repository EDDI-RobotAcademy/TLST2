package kr.eddi.ztz_process.utility;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;
import kr.eddi.ztz_process.entity.products.Local;

@Converter
public class LocalCodeConverter implements AttributeConverter<Local, String> {

    @Override
    public String convertToDatabaseColumn(Local attribute) {
        if(attribute == null) {
            throw new IllegalArgumentException("주종 입력이 되지 않았습니다.");
        }
        return attribute.getLocal();
    }

    @Override
    public Local convertToEntityAttribute(String dbData) {
        if(dbData == null || dbData.isBlank()) {
            throw new IllegalArgumentException("dbData가 비어있습니다.");
        }
        return Local.ofType(dbData);
    }
}
