package kr.eddi.ztz_process.controller.products;

import kr.eddi.ztz_process.controller.products.request.ProductLocalAndTypeRequest;
import kr.eddi.ztz_process.controller.products.request.ProductModifyRequest;
import kr.eddi.ztz_process.controller.products.request.ProductRequest;
import kr.eddi.ztz_process.entity.products.AlcoholType;
import kr.eddi.ztz_process.entity.products.Local;
import kr.eddi.ztz_process.entity.products.Product;
import kr.eddi.ztz_process.repository.search.KeywordRepository;
import kr.eddi.ztz_process.service.products.ProductsService;
import kr.eddi.ztz_process.service.search.SearchService;
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

    @Autowired
    SearchService searchService;

    @Autowired
    KeywordRepository keywordRepository;
    @PostMapping(path = "/list")
    public List<Product> productsList(String keyword) {

        if (keyword == null|| keyword.length() == 0 || keyword ==""){
            return productsService.list();
        }else {
            searchService.registerOrAddCntKeyWord(keyword);
            return productsService.search(keyword);
        }
    }

    @PostMapping(path = "/list/flutter")
    public List<Product> productsFirst(String keyword) {

        if (keyword == null|| keyword.length() == 0 || keyword ==""){
            return productsService.firstPageProduct(); // 필터 없이 첫 페이지 네이션
        }else {
            searchService.registerOrAddCntKeyWord(keyword);
            return productsService.firstPageSearchProduct(keyword); // 검색 첫 페이지 네이션
        }
    }

    @PostMapping("/list/next/flutter")
    public List<Product> productsNext(
            @RequestParam("productNo") Long productNo,
            @RequestParam("keyword") String keyword
    ) {

        if (keyword == null|| keyword.length() == 0 || keyword ==""){
            return productsService.nextPageProduct(productNo); // 필터 없이 처음 이후 페이지 네이션
        }else {
            searchService.registerOrAddCntKeyWord(keyword);
            return productsService.nextPageSearchProduct(productNo,keyword); // 검색 처음 이후 페이지 네이션
        }
    }
    @GetMapping(path = "/list/flutter/{localName}")
    public List<Product> localProductsFirstList(@PathVariable("localName") String localName) {
        String tmp = localName;
        Local filterLocal = Local.valueOfLocalName(tmp);

        return productsService.firstPageLocalProduct(filterLocal); // 지역 필터 첫번째
    }

    @GetMapping(path = "/list/next/flutter/{localName}")
    public List<Product> localProductsNextList(
            @RequestParam("productNo") Long productNo,
            @PathVariable("localName") String localName
    ) {
        String tmp = localName;
        Local filterLocal = Local.valueOfLocalName(tmp);

        return productsService.nextPageLocalProduct(productNo,filterLocal); // 지역 필터 처음 이후
    }

    @GetMapping(path = "/list/{localName}")
    public List<Product> localProductsList(@PathVariable("localName") String localName) {

        String tmp = localName;
        Local filterLocal = Local.valueOfLocalName(tmp);

        return productsService.list(filterLocal);
    }

    @PostMapping("/list/by-local-type/flutter")
    public List<Product> localAndTypeFirstProductList(@RequestBody ProductLocalAndTypeRequest request){
        Local filterLocal = Local.valueOfLocalName(request.getLocalName());
        AlcoholType filterAlcohol = AlcoholType.valueOfAlcoholName(request.getAlcoholType());

        return productsService.firstPageAlcoholTypeAndLocalProduct(filterAlcohol,filterLocal); // 모든 필터 첫 페이지 네이션
    }

    @PostMapping("/list/by-local-type/next/flutter")
    public List<Product> localAndTypeNextProductList(
            @RequestParam("productNo") Long productNo,
            @RequestBody ProductLocalAndTypeRequest request
    ){
        Local filterLocal = Local.valueOfLocalName(request.getLocalName());
        AlcoholType filterAlcohol = AlcoholType.valueOfAlcoholName(request.getAlcoholType());

        return productsService.nextPageAlcoholTypeAndLocalProduct(productNo,filterAlcohol,filterLocal); // 다음 필터 페이지 네이션
    }

    @PostMapping("/list/by-local-type")
    public List<Product> localAndTypeProductList(@RequestBody ProductLocalAndTypeRequest request){

        return productsService.list(request);
    }

    @PostMapping("/alcoholList/flutter/{alcoholType}")
    public List<Product> alcoholProductFirstList(@PathVariable("alcoholType") String alcoholType) {
        String tmp = alcoholType;
        AlcoholType filterAlcohol = AlcoholType.valueOfAlcoholName(tmp);

        return productsService.firstPageAlcoholTypeProduct(filterAlcohol); // 알콜타입으로 첫 페이지 네이션
    }

    @PostMapping("/alcoholList/next/flutter/{alcoholType}")
    public List<Product> alcoholProductNextList(
            @RequestParam("productNo") Long productNo,
            @PathVariable("alcoholType") String alcoholType
    ) {
        String tmp = alcoholType;
        AlcoholType filterAlcohol = AlcoholType.valueOfAlcoholName(tmp);

        return productsService.nextPageAlcoholTypeProduct(productNo,filterAlcohol); // 알콜 타입으로 처음이후 페이지 네이션
    }

    @PostMapping("/alcoholList/{alcoholType}")
    public List<Product> alcoholProductList(@PathVariable("alcoholType") String alcoholType) {
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

    @PostMapping("/list/favorite")
    public List<Product> listByFavorite() {
        return productsService.listByFavorite();
    }

    @PostMapping("/list/product/{productNo}")
    public Product getProductInfo(@PathVariable("productNo") Long productNo) {

        return productsService.getProductInfo(productNo);
    }

    @PostMapping("/monthAlcohol/{productNo}")
    public String checkMonthAlcohol(@PathVariable("productNo") Long productNo) {
        return productsService.checkMonthAlcohol(productNo);
    }
    @GetMapping("/monthAlcohol/list")
    public List<Product> monthAlcoholList() {

        return productsService.monthAlcoholList();
    }

    @ResponseBody
    @PostMapping(value = "/register",
            consumes = {  MediaType.MULTIPART_FORM_DATA_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE, MediaType.APPLICATION_JSON_VALUE }) // 이미지+텍스트 업로드하는 경우 value , consumes 정보(이미지타입, json타입) 추가
    public String registerProduct(
            @RequestPart(value = "thumbnail") List<MultipartFile> thumbnail,
            @RequestPart(value = "fileList") List<MultipartFile> fileList,
            @RequestPart(value = "info") ProductRequest productRequest) {

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

        productsService.modifyProduct(thumbnail, fileList, productModifyRequest);

        return "상품이 수정되었습니다.";
    }

    @DeleteMapping("/{productNo}")
    public void removeProduct (@PathVariable("productNo") Long productNo) {

        productsService.remove(productNo);
    }

    @GetMapping(path = "/list/month/{localName}")
    public List<Product> localMonthList(@PathVariable("localName") String localName) {
        String tmp = localName;
        Local filterLocal = Local.valueOfLocalName(tmp);

        return productsService.monthLocalList(filterLocal);
    }

    @GetMapping(path = "/list/best/{localName}")
    public List<Product> localBestList(@PathVariable("localName") String localName) {
        String tmp = localName;
        Local filterLocal = Local.valueOfLocalName(tmp);

        return productsService.bestLocalList(filterLocal);
    }

    @PostMapping("/list/best/by-local-type")
    public List<Product> localAndTypeBestList(@RequestBody ProductLocalAndTypeRequest request){
        return productsService.bestLocalAndAlcoholList(request);
    }

    @PostMapping("/alcoholList/best/{alcoholType}")
    public List<Product> alcoholBestList(@PathVariable("alcoholType") String alcoholType) {
        String tmp = alcoholType;
        AlcoholType filterAlcohol = AlcoholType.valueOfAlcoholName(tmp);

        return productsService.bestAlcoholList(filterAlcohol);
    }

    @GetMapping(path = "/list/favorite/{localName}")
    public List<Product> localFavoriteList(@PathVariable("localName") String localName) {
        String tmp = localName;
        Local filterLocal = Local.valueOfLocalName(tmp);

        return productsService.favoriteLocalList(filterLocal);
    }

    @PostMapping("/list/favorite/by-local-type")
    public List<Product> localAndTypeFavoriteList(@RequestBody ProductLocalAndTypeRequest request){

        return productsService.favoriteLocalAndAlcoholList(request);
    }

    @PostMapping("/alcoholList/favorite/{alcoholType}")
    public List<Product> alcoholFavoriteList(@PathVariable("alcoholType") String alcoholType) {
        String tmp = alcoholType;
        AlcoholType filterAlcohol = AlcoholType.valueOfAlcoholName(tmp);

        return productsService.favoriteAlcoholList(filterAlcohol);
    }
}
