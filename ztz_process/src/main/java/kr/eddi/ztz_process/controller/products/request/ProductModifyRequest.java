package kr.eddi.ztz_process.controller.products.request;

import lombok.Getter;

import java.util.List;

@Getter
public class ProductModifyRequest {

    private Long productNo;
    private String brand;
    private String name;
    private int price;

    private String type;
    private String local;

    private List<String> taste;

    private String subTitle;

    private String description;
}
