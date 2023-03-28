package kr.eddi.ztz_process.service.search;

import kr.eddi.ztz_process.entity.search.RecommendedKeywords;

import java.util.List;

public interface SearchService {


    List<RecommendedKeywords> returnEntireKeywordList();

    List<RecommendedKeywords> returnSelectedKeywordList();

    String selectKeyword(List<Long> keywordIdList);
    String saveKeyword(String keyword);
    String deleteKeyword(List<Long>  keywordIdList);
    public void registerOrAddCntKeyWord(String searchedKeyword);

    public List<String> readTopTenKeyword();

}
