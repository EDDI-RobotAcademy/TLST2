package kr.eddi.ztz_process.repository.boards;

import kr.eddi.ztz_process.entity.boards.BoardCategory;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BoardCategoryRepository extends JpaRepository<BoardCategory, Long> {
}
