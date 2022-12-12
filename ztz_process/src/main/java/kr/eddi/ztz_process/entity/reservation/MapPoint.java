package kr.eddi.ztz_process.entity.reservation;

import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Embeddable
@NoArgsConstructor
@AllArgsConstructor
public class MapPoint {

    private double lat;
    private double lng;

}
