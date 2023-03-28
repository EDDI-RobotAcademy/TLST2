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
        return service.returnEntireKeywordList();
    }

    @GetMapping("/selected-keywords-list")
    public List<RecommendedKeywords> selectedRecommendedKeywordList() {
        return service.returnSelectedKeywordList();
    }

    @PostMapping("/save")
    public String saveKeyword(@RequestBody AddKeywordRequest addKeywordRequest) {
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
    @PostMapping("/read/top/ten")
    public List<String> readTopTenKeyword(){
        return service.readTopTenKeyword();
    }

}
