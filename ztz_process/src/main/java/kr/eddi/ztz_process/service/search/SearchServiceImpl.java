package kr.eddi.ztz_process.service.search;

import kr.eddi.ztz_process.entity.search.RecommendedKeywords;
import kr.eddi.ztz_process.repository.search.RecommendedKeywordRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@Slf4j
public class SearchServiceImpl implements SearchService{

    @Autowired
    RecommendedKeywordRepository repository;


















    @Override
    public List<RecommendedKeywords> returnEntireKeywordList() {
       return repository.findAll(Sort.by(Sort.Direction.DESC, "recommendedId"));
    }

    @Override
    public List<RecommendedKeywords> returnSelectedKeywordList() {
        log.info(repository.findByKeywordStatus(true).toString());
        return repository.findByKeywordStatus(true);
    }

    @Override
    public String selectKeyword(List<Long> keywordIdList) {
        for(Long i : keywordIdList) {
            RecommendedKeywords rk = repository.findByKeywordId(i);
            rk.setSelected(!rk.isSelected());
            repository.save(rk);
        }
        return "1";
    }

    @Override
    public String saveKeyword(String keyword) {
       Optional<RecommendedKeywords> maybeKeyword = repository.findByKeyword(keyword);

       if(maybeKeyword.isPresent()) {
           return "-1";
       } else {
           RecommendedKeywords rk = new RecommendedKeywords(keyword);
           repository.save(rk);
           return "1";
       }

    }

    @Override
    public String deleteKeyword(List<Long> keywordIdList) {
        for(Long i : keywordIdList) {
            RecommendedKeywords rk = repository.findByKeywordId(i);
            repository.delete(rk);
        }
        return "1";
    }
}
