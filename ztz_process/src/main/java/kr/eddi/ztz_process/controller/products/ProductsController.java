package kr.eddi.ztz_process.controller.products;

import kr.eddi.ztz_process.controller.products.request.ProductLocalAndTypeRequest;
import kr.eddi.ztz_process.controller.products.request.ProductModifyRequest;
import kr.eddi.ztz_process.controller.products.request.ProductRequest;
import kr.eddi.ztz_process.entity.products.AlcoholType;
import kr.eddi.ztz_process.entity.products.Local;
import kr.eddi.ztz_process.entity.products.Product;
import kr.eddi.ztz_process.service.products.ProductsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;


@Slf4j
@RestController
@RequestMapping("ztz/products")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ProductsController {

    @Autowired
    ProductsService productsService;

    @PostMapping(path = "/list")
    public List<Product> productsList(String keyword) {
        log.info("키워드 = " + keyword );

        if (keyword == null|| keyword.length() == 0 || keyword ==""){
            return productsService.list();
        }else {
            return productsService.search(keyword);
        }
    }

    @GetMapping(path = "/list/{localName}")
    public List<Product> localProductsList(@PathVariable("localName") String localName) {
        log.info("받은 지역데이터:" +localName);
        String tmp = localName;
        Local filterLocal = Local.valueOfLocalName(tmp);

        return productsService.list(filterLocal);
    }

    @PostMapping("/list/by-local-type")
    public List<Product> localAndTypeProductList(@RequestBody ProductLocalAndTypeRequest request){
        log.info("지역과 타입으로 상품 조회");
        log.info("지역 = " + request.getLocalName());
        log.info("타입 = " + request.getAlcoholType());

        return productsService.list(request);
    }

    @PostMapping("/alcoholList/{alcoholType}")
    public List<Product> alcoholProductList(@PathVariable("alcoholType") String alcoholType) {
        log.info("받은 알코올타입:" +alcoholType);
        String tmp = alcoholType;
        AlcoholType filterAlcohol = AlcoholType.valueOfAlcoholName(tmp);

        return productsService.alcoholList(filterAlcohol);
    }

    @PostMapping("/list/view")
    public List<Product> listByView() {
        return productsService.listByView();
    }

    @PostMapping("/list/view/recommend")
    public List<Product> recommendListByView() {
        return productsService.recommendListByView();
    }

    @PostMapping("/list/product/{productNo}")
    public Product getProductInfo(@PathVariable("productNo") Long productNo) {
        log.info("상품 상세 - 상품 정보 가져오기: " + productNo);

        return productsService.getProductInfo(productNo);
    }

    @PostMapping("/monthAlcohol/{productNo}")
    public String checkMonthAlcohol(@PathVariable("productNo") Long productNo) {
        log.info("이달의 술 선정: " + productNo);
        return productsService.checkMonthAlcohol(productNo);
    }
    @GetMapping("/monthAlcohol/list")
    public List<Product> monthAlcoholList() {
        log.info("이달의 술 리스트 조회");

        return productsService.monthAlcoholList();
    }

    @ResponseBody
    @PostMapping(value = "/register",
            consumes = {  MediaType.MULTIPART_FORM_DATA_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE, MediaType.APPLICATION_JSON_VALUE }) // 이미지+텍스트 업로드하는 경우 value , consumes 정보(이미지타입, json타입) 추가
    public String registerProduct(
            @RequestPart(value = "thumbnail") List<MultipartFile> thumbnail,
            @RequestPart(value = "fileList") List<MultipartFile> fileList,
            @RequestPart(value = "info") ProductRequest productRequest) {

        log.info("상품등록 컨트롤러-파일리스트: " + fileList.toString());
        log.info("상품등록 컨트롤러-리퀘스트내용: " + productRequest);

        productsService.registerProduct(thumbnail, fileList, productRequest);

        return "상품이 등록되었습니다.";
    }

    @ResponseBody
    @PostMapping(value = "/modify",
            consumes = {  MediaType.MULTIPART_FORM_DATA_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE, MediaType.APPLICATION_JSON_VALUE })
    public String modifyProduct(
            @RequestPart(value = "thumbnail",required = false) List<MultipartFile> thumbnail,
            @RequestPart(value = "fileList",required = false) List<MultipartFile> fileList,
            @RequestPart(value = "info") ProductModifyRequest productModifyRequest) {

        log.info("상품수정 컨트롤러-리퀘스트내용: " + productModifyRequest);

        productsService.modifyProduct(thumbnail, fileList, productModifyRequest);

        return "상품이 수정되었습니다.";
    }

    @DeleteMapping("/{productNo}")
    public void removeProduct (@PathVariable("productNo") Long productNo) {
        log.info("상품 삭제 번호():" + productNo);

        productsService.remove(productNo);
    }

    @GetMapping(path = "/list/month/{localName}")
    public List<Product> localMonthList(@PathVariable("localName") String localName) {
        log.info("받은 지역데이터 - 이달의 술:" +localName);
        String tmp = localName;
        Local filterLocal = Local.valueOfLocalName(tmp);

        return productsService.monthLocalList(filterLocal);
    }

    @GetMapping(path = "/list/best/{localName}")
    public List<Product> localBestList(@PathVariable("localName") String localName) {
        log.info("받은 지역데이터 - 베스트:" +localName);
        String tmp = localName;
        Local filterLocal = Local.valueOfLocalName(tmp);

        return productsService.bestLocalList(filterLocal);
    }

    @PostMapping("/list/best/by-local-type")
    public List<Product> localAndTypeBestList(@RequestBody ProductLocalAndTypeRequest request){
        log.info("지역과 타입으로 베스트 상품 조회");
        log.info("지역 = " + request.getLocalName());
        log.info("타입 = " + request.getAlcoholType());

        return productsService.bestLocalAndAlcoholList(request);
    }

    @PostMapping("/alcoholList/best/{alcoholType}")
    public List<Product> alcoholBestList(@PathVariable("alcoholType") String alcoholType) {
        log.info("받은 알코올타입 - 베스트:" +alcoholType);
        String tmp = alcoholType;
        AlcoholType filterAlcohol = AlcoholType.valueOfAlcoholName(tmp);

        return productsService.bestAlcoholList(filterAlcohol);
    }
}
