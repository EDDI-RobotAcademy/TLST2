package kr.eddi.ztz_process.controller.boards;

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

    // 질문게시판 리스트 UI 시스템
    @GetMapping("/list")
    public List<QuestionBoard> questionBoardList () {
        log.info("questionBoardList()");

        return questionService.questionList();
    }

//     // 질문게시판 게시물 조회(읽기)
//    @GetMapping("/{questionNo}")
//    public QuestionBoard questionBoardRead (@PathVariable("questionNo") Long questionNo) {
//        log.info("questionBoardRead()");
//
//        return questionService.questionRead(questionNo);
//    }
//
//     // 질문게시판 게시물 등록
//    @PostMapping("/register")
//    public void questionBoardRegister (@RequestBody BoardsRequest boardsRequest) {
//        log.info("questionBoardRegister()");
//
//        questionService.questionRegister(boardsRequest);
//    }
//
//     // 질문게시판 게시물 수정
//    @PutMapping("/{questionNo}")
//    public QuestionBoard questionBoardModify (@PathVariable("questionNo") Long questionNo, @RequestBody QuestionBoard questionBoard) {
//        log.info("questionBoardModify()");
//
//        questionBoard.setQuestionNo(questionNo);
//        questionService.questionModify(questionBoard);
//
//        return questionBoard;
//    }
//
//    // 질문게시판 게시물 삭제
//    @DeleteMapping("/{questionNo}")
//    public void questionBoardRemove (@PathVariable("questionNo") Long questionNo) {
//        log.info("questionBoardRemove()");
//
//        questionService.questionRemove(questionNo);
//    }
}
