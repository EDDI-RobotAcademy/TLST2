package kr.eddi.ztz_process.controller.boards;

import lombok.Getter;

@Getter
public class BoardsRequest {
    private String title;
    private String writer;
    private String content;
    private Long memberId;
    private String categoryType;
}
