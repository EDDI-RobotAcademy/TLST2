package kr.eddi.ztz_process.repository.boards;

import kr.eddi.ztz_process.entity.boards.QuestionBoard;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface QuestionRepository extends JpaRepository<QuestionBoard, Long> {
    @Query("select qb from QuestionBoard qb join fetch qb.boardCategory join fetch qb.member m where m.id = :memberId")
    List<QuestionBoard> findByMemberId(Long memberId);

    // findById 사용 시 boardCategory lazy-Proxy 오류 발생으로 query 작성
    @Query("select qb from QuestionBoard qb join fetch qb.boardCategory join fetch qb.member where qb.questionNo = :questionNo")
    QuestionBoard findBoardById(Long questionNo);

    @Query("select qb from QuestionBoard qb join fetch qb.boardCategory order by qb.questionNo desc ")
    List<QuestionBoard> findAllBy();


}