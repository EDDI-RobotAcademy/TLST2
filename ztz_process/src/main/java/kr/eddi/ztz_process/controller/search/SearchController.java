package kr.eddi.ztz_process.controller.search;

import kr.eddi.ztz_process.controller.search.request.AddKeywordRequest;
import kr.eddi.ztz_process.controller.search.request.KeywordListRequest;
import kr.eddi.ztz_process.entity.search.RecommendedKeywords;
import kr.eddi.ztz_process.service.search.SearchService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


import java.util.List;

@Slf4j
@RestController
@RequestMapping("ztz/search")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class SearchController {

    @Autowired
    SearchService service;



















    @GetMapping("/all-keywords-list")
    public List<RecommendedKeywords> recommendedKeywordList() {
        log.info("모든 추천키워드 리스트 요청");
        return service.returnEntireKeywordList();
    }

    @GetMapping("/selected-keywords-list")
    public List<RecommendedKeywords> selectedRecommendedKeywordList() {
        return service.returnSelectedKeywordList();
    }

    @PostMapping("/save")
    public String saveKeyword(@RequestBody AddKeywordRequest addKeywordRequest) {
        log.info("저장" + addKeywordRequest.getEnterKeyword());
        return service.saveKeyword(addKeywordRequest.getEnterKeyword());
    }

    @PostMapping("/delete")
    public void removeKeyword (@RequestBody KeywordListRequest keywordListRequest) {
        service.deleteKeyword(keywordListRequest.getSelectedKeywords());
    }

    @PostMapping("/select")
    public String selectUseKeyword(@RequestBody KeywordListRequest keywordListRequest)  {
        return service.selectKeyword(keywordListRequest.getSelectedKeywords());
    }
}
