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
    public List<QuestionComment> questionCommentList() {
        return questionCommentRepository.findAll(Sort.by(Sort.Direction.DESC, "questionCommentNo"));
    }

    // 댓글 등록
    @Override
    public void questionCommentRegister(CommentRequest commentRequest) {
        Optional<Member> maybeMember = memberRepository.findById(commentRequest.getMember_no()); // Request를 토대로 찾은 멤버를 세팅 및 저장
        Member member = maybeMember.get();
        QuestionComment questionComment = new QuestionComment();
        questionComment.setCommentWriter(commentRequest.getCommentWriter());
        questionComment.setComment(commentRequest.getComment());
        questionComment.setMember(member); // Member
        Optional<QuestionBoard> maybeBoard = questionRepository.findById(commentRequest.getQuestion_no());
        QuestionBoard board = maybeBoard.get();
        questionComment.setQuestionBoard(board);

        questionCommentRepository.save(questionComment);
    }

    // 댓글 삭제
    @Override
    public void questionCommentRemove(Long questionCommentNo) {
        questionCommentRepository.deleteById(Long.valueOf(questionCommentNo));

    }
}