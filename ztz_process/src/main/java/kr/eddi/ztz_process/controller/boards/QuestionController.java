package kr.eddi.ztz_process.controller.boards;

import kr.eddi.ztz_process.controller.boards.request.BoardsRequest;
import kr.eddi.ztz_process.controller.member.form.MemberLoggedInTokenForm;
import kr.eddi.ztz_process.entity.boards.QuestionBoard;
import kr.eddi.ztz_process.service.boards.QuestionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("ztz/boards/question")
@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")
public class QuestionController {
    @Autowired
    private QuestionService questionService;

    @GetMapping("/list")
    public List<QuestionBoard> questionBoardList () {
        return questionService.questionList();
    }

    @PostMapping("/list/member")
    public List<QuestionBoard> memberQuestionBoardList (@RequestBody MemberLoggedInTokenForm memberLoggedInTokenForm) {
        String tmpToken = "";
        if(memberLoggedInTokenForm.getToken().length() >= 37){
            tmpToken = memberLoggedInTokenForm.getToken().substring(1,37);
        }else {
            tmpToken = memberLoggedInTokenForm.getToken();
        }

        return questionService.memberQuestionList(tmpToken);
    }

    @GetMapping("/{questionNo}")
    public QuestionBoard questionBoardRead (@PathVariable("questionNo") Long questionNo) {
        return questionService.questionRead(questionNo);
    }

    @PostMapping("/register")
    public void questionBoardRegister (@RequestBody BoardsRequest boardsRequest) {
        questionService.questionRegister(boardsRequest);
    }

     @PutMapping("/{questionNo}")
     public void modifyQuestionBoard (@PathVariable("questionNo") Long questionNo, @RequestBody BoardsRequest boardsRequest) {
         questionService.modify(questionNo, boardsRequest);
     }

    @DeleteMapping("/{questionNo}")
    public void questionBoardRemove (@PathVariable("questionNo") Long questionNo) {
        questionService.questionRemove(questionNo);
    }
}
