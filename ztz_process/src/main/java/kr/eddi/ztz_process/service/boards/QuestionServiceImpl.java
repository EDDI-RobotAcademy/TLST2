package kr.eddi.ztz_process.service.boards;

import kr.eddi.ztz_process.controller.boards.BoardsRequest;
import kr.eddi.ztz_process.entity.boards.BoardCategory;
import kr.eddi.ztz_process.entity.boards.BoardCategoryType;
import kr.eddi.ztz_process.entity.boards.QuestionBoard;
import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.repository.boards.QuestionRepository;
import kr.eddi.ztz_process.repository.member.MemberRepository;
import kr.eddi.ztz_process.service.security.RedisService;
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

    @Autowired
    MemberRepository memberRepository;
    

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

     // 질문게시판 게시물 등록
    @Override
    public void questionRegister(BoardsRequest boardsRequest) {

        QuestionBoard questionBoard = new QuestionBoard();

        Optional<Member> maybeMember = memberRepository.findById(boardsRequest.getMemberId());

        questionBoard.setTitle(boardsRequest.getTitle());
        questionBoard.setContent(boardsRequest.getContent());
        questionBoard.setWriter(boardsRequest.getWriter());
        questionBoard.setMember(maybeMember.get());
        questionBoard.setBoardCategory(registerBoardCategory(boardsRequest.getCategoryType()));

        questionRepository.save(questionBoard);
    }

    //질문 등록 시 카테고리 타입 지정하는 메소드
    public BoardCategory registerBoardCategory(String categoryTypeRequest) {
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

        BoardCategory boardCategory = new BoardCategory(categoryType);
        return boardCategory;
    }

     // 질문게시판 게시물 수정
    @Override
    public void questionModify(QuestionBoard questionBoard) {
        questionRepository.save(questionBoard);
    }

    // 질문게시판 게시물 삭제
    @Override
    public void questionRemove(Long questionNo) {
        questionRepository.deleteById(Long.valueOf(questionNo));
    }
}
