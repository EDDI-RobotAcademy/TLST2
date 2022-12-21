package kr.eddi.ztz_process.service.boards;

//import kr.eddi.ztz_process.controller.boards.CommentRequest;
import kr.eddi.ztz_process.entity.boards.QuestionBoard;
import kr.eddi.ztz_process.entity.boards.QuestionComment;
import kr.eddi.ztz_process.repository.boards.QuestionCommentRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
public class QuestionCommentServiceImpl implements QuestionCommentService {

    @Autowired
    QuestionCommentRepository questionCommentRepository;

    @Autowired
    QuestionRepository questionRepository;

    // 댓글 리스트
    @Override
    public List<QuestionComment> questionCommentList() {
        return questionCommentRepository.findAll(Sort.by(Sort.Direction.DESC, "questionCommentNo"));
    }

    // 댓글 등록
//    @Override
//    public void questionCommentRegister(CommentRequest commentRequest) {
//        QuestionComment questionComment = new QuestionComment();
//        questionComment.setCommentWriter(commentRequest.getCommentWriter());
//        questionComment.setComment(commentRequest.getComment());
//        Optional<QuestionBoard> maybeBoard = questionRepository.findById(commentRequest.getQuestion_no());
//        QuestionBoard board = maybeBoard.get();
//        questionComment.setQuestionBoard(board);
//
//        questionCommentRepository.save(questionComment);
//    }
}