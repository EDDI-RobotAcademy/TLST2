package kr.eddi.ztz_process.controller.boards;

import lombok.Getter;

@Getter
public class CommentRequest {

    private String commentWriter;
    private String comment;
    private Long question_no;
    private Long member_no;
}