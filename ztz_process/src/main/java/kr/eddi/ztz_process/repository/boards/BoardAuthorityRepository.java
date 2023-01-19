package kr.eddi.ztz_process.repository.boards;

import kr.eddi.ztz_process.entity.boards.BoardAuthority;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BoardAuthorityRepository extends JpaRepository<BoardAuthority, Long> {
}
