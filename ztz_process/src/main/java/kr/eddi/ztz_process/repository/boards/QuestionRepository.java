package kr.eddi.ztz_process.repository.boards;

import kr.eddi.ztz_process.entity.boards.QuestionBoard;
import org.springframework.data.jpa.repository.JpaRepository;

public interface QuestionRepository extends JpaRepository<QuestionBoard, Long> {
}