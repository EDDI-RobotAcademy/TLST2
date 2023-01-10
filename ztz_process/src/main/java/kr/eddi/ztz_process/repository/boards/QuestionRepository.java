package kr.eddi.ztz_process.repository.boards;

import kr.eddi.ztz_process.entity.boards.QuestionBoard;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface QuestionRepository extends JpaRepository<QuestionBoard, Long> {
    @Query("select qb from QuestionBoard qb join fetch qb.boardCategory join fetch qb.member m where m.id = :memberId")
    List<QuestionBoard> findByMemberId(Long memberId);

//    @Query("select qb from QuestionBoard qb join fetch qb.member")
//    List<QuestionBoard> findAllBy();

}