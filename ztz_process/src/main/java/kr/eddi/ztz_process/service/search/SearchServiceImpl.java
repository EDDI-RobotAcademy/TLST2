package kr.eddi.ztz_process.service.search;

import kr.eddi.ztz_process.entity.search.Keyword;
import kr.eddi.ztz_process.entity.search.RecommendedKeywords;
import kr.eddi.ztz_process.repository.member.MemberRepository;
import kr.eddi.ztz_process.repository.search.KeywordRepository;
import kr.eddi.ztz_process.repository.search.RecommendedKeywordRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Slf4j
public class SearchServiceImpl implements SearchService {

    @Autowired
    RecommendedKeywordRepository repository;
    @Autowired
    KeywordRepository keywordRepository;

    @Autowired
    MemberRepository memberRepository;

    @Override
    public void registerOrAddCntKeyWord(String searchedKeyword) {
        String replaceKeyword = searchedKeyword.replaceAll(" ", "");
        Optional<List<Keyword>> maybeKeyword = keywordRepository.findByKeyword(replaceKeyword);
        if (maybeKeyword.get().isEmpty()) {
            Keyword keyword = Keyword.builder().searchedCnt(1).keyword(replaceKeyword).build();
            keywordRepository.save(keyword);
        } else {
            for (int i = 0; i < maybeKeyword.get().size(); i++) {
                addKeywordCount(maybeKeyword.get().get(i).getKeywordNo());
            }
        }
    }

    @Override
    public List<String> readTopTenKeyword() {
        List<Keyword> keywordEntityList = keywordRepository.findTopTenBySearchedCnt(Pageable.ofSize(10));

        List<String> keywordList = new ArrayList<>();

        for (int i = 0; i < keywordEntityList.size(); i++) {
            System.out.println(keywordEntityList.get(i).getKeyword());
            keywordList.add(keywordEntityList.get(i).getKeyword());
        }

        return keywordList;
    }

    public void addKeywordCount(Long keywordId) {
        Optional<Keyword> maybeKeyword = keywordRepository.findById(keywordId);

        Keyword keyword = maybeKeyword.get();

        int tmpKeywordCnt = keyword.getSearchedCnt();
        keyword.setSearchedCnt(tmpKeywordCnt + 1);

        keywordRepository.save(keyword);
    }

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
        for (Long i : keywordIdList) {
            RecommendedKeywords rk = repository.findByKeywordId(i);
            rk.setSelected(!rk.isSelected());
            repository.save(rk);
        }
        return "1";
    }

    @Override
    public String saveKeyword(String keyword) {
        Optional<RecommendedKeywords> maybeKeyword = repository.findByKeyword(keyword);

        if (maybeKeyword.isPresent()) {
            return "-1";
        } else {
            RecommendedKeywords rk = new RecommendedKeywords(keyword);
            repository.save(rk);
            return "1";
        }

    }

    @Override
    public String deleteKeyword(List<Long> keywordIdList) {
        for (Long i : keywordIdList) {
            RecommendedKeywords rk = repository.findByKeywordId(i);
            repository.delete(rk);
        }
        return "1";
    }
}
