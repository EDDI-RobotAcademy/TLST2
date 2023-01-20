package kr.eddi.ztz_process.service.boards;

import kr.eddi.ztz_process.controller.boards.request.BoardsRequest;
import kr.eddi.ztz_process.entity.boards.*;
import kr.eddi.ztz_process.entity.boards.product_question.BoardAuthorityType;
import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.repository.boards.*;
import kr.eddi.ztz_process.repository.member.MemberRepository;
import kr.eddi.ztz_process.service.security.RedisService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
public class QuestionServiceImpl implements QuestionService {
    @Autowired
    QuestionRepository questionRepository;

    @Autowired
    MemberRepository memberRepository;

    @Autowired
    RedisService redisService;

    @Autowired
    QuestionCommentRepository questionCommentRepository;

    @Autowired
    BoardCategoryRepository categoryRepository;


    @Autowired
    BoardAuthorityRepository authorityRepository;

    // 질문게시판 리스트 UI
    @Override
    public List<QuestionBoard> questionList() {
        return questionRepository.findAllBy();
    }

    @Override
    public List<QuestionBoard> memberQuestionList(String token) {
        Long memberId = redisService.getValueByKey(token);
        return questionRepository.findByMemberId(memberId);
    }

    // 질문게시판 조회(읽기)
    @Override
    public QuestionBoard questionRead(Long questionNo) {
        Optional<QuestionBoard> maybeBoard = Optional.ofNullable(questionRepository.findBoardById(questionNo));

        if (maybeBoard.equals(Optional.empty())) {
            log.info("해당하는 questionBoard 없음!");
            return null;
        } else {
            return maybeBoard.get();
        }
    }

     // 질문게시판 게시물 등록
    @Override
    public void questionRegister(BoardsRequest boardsRequest) {

        QuestionBoard questionBoard = new QuestionBoard();

        BoardCategory boardCategory = new BoardCategory(registerBoardCategory(boardsRequest.getCategoryType()));

        Optional<Member> maybeMember = memberRepository.findById(boardsRequest.getMemberId());

        questionBoard.setTitle(boardsRequest.getTitle());
        questionBoard.setContent(boardsRequest.getContent());

        questionBoard.setMember(maybeMember.get());
        questionBoard.setBoardCategory(boardCategory);
        questionRepository.save(questionBoard);
    }

    //질문 등록 시 카테고리 타입 지정하는 메소드
    public BoardCategoryType registerBoardCategory(String categoryTypeRequest) {
        String inputCategory = categoryTypeRequest;

        BoardCategoryType categoryType = null;

        switch (inputCategory) {
            case "주문/결제문의":
                categoryType = BoardCategoryType.ORDER_PAYMENT;
                break;
            case "상품문의":
                categoryType = BoardCategoryType.PRODUCT;
                break;
            case "배송문의":
                categoryType = BoardCategoryType.DELIVERY;
                break;
            case "반품/교환문의":
                categoryType = BoardCategoryType.RETURN_CHANGE;
                break;
            case "양조장문의":
                categoryType = BoardCategoryType.TOUR;
                break;
            case "기타문의":
                categoryType = BoardCategoryType.OTHER;
                break;
        }
        log.info(categoryType.toString());
        return categoryType;
    }

    public BoardAuthorityType registerBoardAuthority(String boardAuthorityTypeRequest) {
        String inputAuthority = boardAuthorityTypeRequest;

        BoardAuthorityType boardAuthorityType = null;

        switch (inputAuthority) {
            case "비공개":
                boardAuthorityType = BoardAuthorityType.PRIVATE_AUTHORITY;
                break;
            case "공개":
                boardAuthorityType = BoardAuthorityType.PUBLIC_AUTHORITY;
                break;
        }
        log.info(boardAuthorityType.toString());
        return boardAuthorityType;
    }

     // 질문게시판 게시물 수정
    @Override
    public void modify(Long questionNo, BoardsRequest boardsRequest) {
        Optional<QuestionBoard> maybeBoard = Optional.ofNullable(questionRepository.findBoardById(questionNo));
        QuestionBoard questionBoard = maybeBoard.get();

        // 카테고리 지정
        Optional<BoardCategory> maybeCategory = categoryRepository.findById(questionBoard.getBoardCategory().getId());
        BoardCategory boardCategory = maybeCategory.get();
        boardCategory.setCategoryType(registerBoardCategory(boardsRequest.getCategoryType()));
        categoryRepository.save(boardCategory);

        if (maybeBoard.equals(Optional.empty())) {
            log.info("해당하는 questionBoard 없음!");
        } else {
            questionBoard.setTitle(boardsRequest.getTitle());
            questionBoard.setContent(boardsRequest.getContent());
            questionBoard.setBoardCategory(boardCategory);
            questionRepository.save(questionBoard);
        }
    }

    // 질문게시판 게시물 삭제
    @Override
    public void questionRemove(Long questionNo) {

        List<QuestionComment> commentList = questionCommentRepository.findCommentByQuestionNo(questionNo);

        // 댓글 삭제
        for (QuestionComment comment : commentList) {
            questionCommentRepository.delete(comment);
        }

        Optional<QuestionBoard> maybeBoard = questionRepository.findById(questionNo);
        Long categoryId = maybeBoard.get().getBoardCategory().getId();

        questionRepository.deleteById(questionNo); // 보드를 먼저 삭제 후

        categoryRepository.deleteById(categoryId); // 카테고리 삭제 가능
    }
}
