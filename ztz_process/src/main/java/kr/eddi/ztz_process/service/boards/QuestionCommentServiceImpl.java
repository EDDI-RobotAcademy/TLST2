package kr.eddi.ztz_process.service.boards;

import kr.eddi.ztz_process.controller.boards.CommentRequest;
import kr.eddi.ztz_process.entity.boards.QuestionBoard;
import kr.eddi.ztz_process.entity.boards.QuestionComment;
import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.repository.boards.QuestionCommentRepository;
import kr.eddi.ztz_process.repository.boards.QuestionRepository;
import kr.eddi.ztz_process.repository.member.MemberRepository;
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

    @Autowired
    MemberRepository memberRepository;

    // 댓글 리스트
    @Override
    public List<QuestionComment> questionCommentList(Long questionNo) {
        return questionCommentRepository.findCommentByQuestionNo(questionNo);
    }

    @Override
    public QuestionComment questionComment(Long questionNo) {
        return questionCommentRepository.findByQuestionNo(questionNo);
    }

    // 댓글 등록
    @Override
    public void questionCommentRegister(CommentRequest commentRequest) {
        Optional<Member> maybeMember = memberRepository.findById(commentRequest.getMember_no()); // Request를 토대로 찾은 멤버를 세팅 및 저장
        Member member = maybeMember.get();
        QuestionComment questionComment = new QuestionComment();
//        questionComment.setCommentWriter(commentRequest.getCommentWriter());
        questionComment.setComment(commentRequest.getComment());
        questionComment.setMember(member); // Member
        // 댓글 등록 시 게시판 답변 상태 변경
        Optional<QuestionBoard> maybeBoard = questionRepository.findById(commentRequest.getQuestion_no());
        QuestionBoard board = maybeBoard.get();
        board.setAnswerState("답변완료");
        questionRepository.save(board);
        questionComment.setQuestionBoard(board);

        questionCommentRepository.save(questionComment);
    }

    // 댓글 삭제
    @Override
    public void questionCommentRemove(Long questionCommentNo) {
        // 댓글 삭제 시 게시판 답변 상태 변경
        Optional<QuestionComment> maybeComment = questionCommentRepository.findById(questionCommentNo);
        QuestionComment questionComment = maybeComment.get();
        Optional<QuestionBoard> maybeBoard = Optional.ofNullable(questionRepository.findBoardById(questionComment.getQuestionBoard().getQuestionNo()));
        QuestionBoard questionBoard = maybeBoard.get();
        questionBoard.setAnswerState("답변대기");
        questionRepository.save(questionBoard);
        // 댓글 삭제
        questionCommentRepository.deleteById(questionCommentNo);
    }
}