package kr.eddi.ztz_process.controller.search;

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
    public String saveKeyword() {
        return service.saveKeyword("블루");
    }

    @DeleteMapping("/delete")
    public void removeKeyword () {
        List<Long> delete = List.of(1L);
        service.deleteKeyword(delete);
    }

    @PostMapping("/select")
    public String selectUseKeyword() {
        List<Long> select = List.of(1L);
        return service.selectKeyword(select);
    }
}
