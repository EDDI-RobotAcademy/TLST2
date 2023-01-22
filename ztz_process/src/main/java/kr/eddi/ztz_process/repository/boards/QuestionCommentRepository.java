package kr.eddi.ztz_process.repository.boards;

import kr.eddi.ztz_process.entity.boards.QuestionComment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface QuestionCommentRepository extends JpaRepository<QuestionComment, Long> {

    @Query("select c from QuestionComment c join fetch c.member join fetch c.questionBoard q where q.questionNo = :questionNo")
    List<QuestionComment> findCommentByQuestionNo(Long questionNo);

    @Query("select c from QuestionComment c join fetch c.member join fetch c.questionBoard q where q.questionNo = :questionNo")
    QuestionComment findByQuestionNo(Long questionNo);

    @Query("select c from QuestionComment c join fetch c.member join fetch c.questionBoard q where q.questionNo = :questionNo")
    Optional<QuestionComment> findOptionalByQuestionNo(Long questionNo);
}