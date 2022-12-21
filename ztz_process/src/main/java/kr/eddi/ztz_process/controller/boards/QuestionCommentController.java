package kr.eddi.ztz_process.controller.boards;

import kr.eddi.ztz_process.entity.boards.QuestionComment;
import kr.eddi.ztz_process.service.boards.QuestionCommentService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("ztz/boards/question/comment")
@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")
public class QuestionCommentController {

    @Autowired
    QuestionCommentService questionCommentService;

    @GetMapping("/{questionNo}")
    public List<QuestionComment> questionCommentList() {
        log.info("questionCommentList()");

        return questionCommentService.questionCommentList();
    }

//    @PostMapping("/register")
//    public void questionCommentRegister(@RequestBody CommentRequest commentRequest) {
//        log.info("questionCommentRegister()" + commentRequest.getQuestion_no());
//
//        questionCommentService.questionCommentRegister(commentRequest);
//    }
}