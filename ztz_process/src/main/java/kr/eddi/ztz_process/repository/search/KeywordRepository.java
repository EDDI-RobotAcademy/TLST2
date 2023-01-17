package kr.eddi.ztz_process.repository.search;

import kr.eddi.ztz_process.entity.search.Keyword;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface KeywordRepository extends JpaRepository<Keyword, Long> {

    @Query("select k from Keyword k where k.keyword like %:keyword% order by k.keywordNo desc")
    Optional<List<Keyword>> findByKeyword(String keyword);

    @Query("select k from Keyword k order by k.searchedCnt desc")
    List<Keyword> findTopTenBySearchedCnt(Pageable pageable);
}
