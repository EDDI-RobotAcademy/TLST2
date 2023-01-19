package kr.eddi.ztz_process.utility.product;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.persistence.AttributeConverter;

import java.io.IOException;
import java.util.List;

public class StringListConverter implements AttributeConverter<List<String>, String> {
    private static final ObjectMapper mapper = new ObjectMapper()
            .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)
            .configure(DeserializationFeature.FAIL_ON_NULL_FOR_PRIMITIVES, false);

    // DB 테이블에 들어갈 때 적용됨
    @Override
    public String convertToDatabaseColumn(List<String> attribute) {
        try {
            // Object to JSON in String
            return mapper.writeValueAsString(attribute);
        } catch (JsonProcessingException e) {
            throw new IllegalArgumentException();
        }

    }

    // DB 테이블의 데이터를 Object 에 매핑시킬 때 적용됨
    @Override
    public List<String> convertToEntityAttribute(String dbData) {
        try {
            // JSON from String to Object
            return mapper.readValue(dbData, List.class);
        } catch (IOException e) {
            throw new IllegalArgumentException();
        }
    }
}