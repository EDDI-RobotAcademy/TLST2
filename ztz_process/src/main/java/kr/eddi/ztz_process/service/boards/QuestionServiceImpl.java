package kr.eddi.ztz_process.service.boards;

import kr.eddi.ztz_process.controller.boards.BoardsRequest;
import kr.eddi.ztz_process.entity.boards.QuestionBoard;
import kr.eddi.ztz_process.repository.boards.QuestionRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
public class QuestionServiceImpl implements QuestionService {
    @Autowired
    QuestionRepository questionRepository;

    // 질문게시판 리스트 UI
    @Override
    public List<QuestionBoard> questionList() {
        return questionRepository.findAll(Sort.by(Sort.Direction.DESC, "questionNo"));
    }

    // 질문게시판 조회(읽기)
    @Override
    public QuestionBoard questionRead(Long questionNo) {
        Optional<QuestionBoard> maybeBoard = questionRepository.findById(Long.valueOf(questionNo));

        if (maybeBoard.equals(Optional.empty())) {
            log.info("조회할 수 없습니다!");
            return null;
        }

        return maybeBoard.get();
    }

//     // 질문게시판 게시물 등록
//    public void questionRegister(BoardsRequest boardsRequest) {
//        QuestionBoard questionBoard = new QuestionBoard();
//        questionBoard.setTitle(boardsRequest.getTitle());
//        questionBoard.setContent(boardsRequest.getContent());
//        questionBoard.setWriter(boardsRequest.getWriter());
//
//        questionRepository.save(questionBoard);
//    }
//
//     // 질문게시판 게시물 수정
//    @Override
//    public void questionModify(QuestionBoard questionBoard) {
//        questionRepository.save(questionBoard);
//    }
//
//    // 질문게시판 게시물 삭제
//    @Override
//    public void questionRemove(Long questionNo) {
//        questionRepository.deleteById(Long.valueOf(questionNo));
//    }
}
