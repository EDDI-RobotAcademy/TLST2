package kr.eddi.ztz_process.service.search;

import kr.eddi.ztz_process.entity.search.RecommendedKeywords;

import java.util.List;

public interface SearchService {


    //모든 추천 키워드 반환(관리자용)
    List<RecommendedKeywords> returnEntireKeywordList();
    //선
    List<RecommendedKeywords> returnSelectedKeywordList();
    //검색 페이지에서 띄울 키워드를 선택
    String selectKeyword(List<Long> keywordIdList);
    String saveKeyword(String keyword);
    String deleteKeyword(List<Long>  keywordIdList);
    public void registerOrAddCntKeyWord(String searchedKeyword);

    public List<String> readTopTenKeyword();

}
