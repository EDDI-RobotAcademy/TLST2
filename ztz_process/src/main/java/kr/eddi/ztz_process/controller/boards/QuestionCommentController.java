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
    public List<QuestionComment> questionCommentList(@PathVariable("questionNo") Long questionNo) {
        log.info("questionCommentList()");

        return questionCommentService.questionCommentList(questionNo);
    }

    @PostMapping("/register")
    public void questionCommentRegister(@RequestBody CommentRequest commentRequest) { // URL 보낼거면 CommentRequest 양식에 맞게 보내셈!
        log.info("questionCommentRegister()" + commentRequest.getQuestion_no());
        log.info(commentRequest.getComment());
        log.info(commentRequest.getCommentWriter()); // commentWriter의 데이터를 가져온걸 확인
//        log.info(commentRequest.getQuestion_no());
//        log.info(commentRequest.getMember_no());
        questionCommentService.questionCommentRegister(commentRequest);
    }

    @DeleteMapping("/{questionCommentNo}")
    public void questionCommentRemove (@PathVariable("questionCommentNo") Long questionCommentNo) {
        log.info("questionBoardRemove()");

        questionCommentService.questionCommentRemove(questionCommentNo);
    }
}