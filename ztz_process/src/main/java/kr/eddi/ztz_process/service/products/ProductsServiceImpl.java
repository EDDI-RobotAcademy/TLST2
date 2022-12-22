package kr.eddi.ztz_process.service.products;

import kr.eddi.ztz_process.controller.products.request.ProductModifyRequest;
import kr.eddi.ztz_process.controller.products.request.ProductRequest;
import kr.eddi.ztz_process.entity.products.*;
import kr.eddi.ztz_process.repository.products.ProductsRepository;
import kr.eddi.ztz_process.utility.order.setRandomOrderNo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Slf4j
@Service
public class ProductsServiceImpl implements ProductsService{
    @Autowired
    ProductsRepository repository;
    @Override
    public List<Product> list() {
        return repository.findAll(Sort.by(Sort.Direction.DESC, "productNo"));
    }
    @Override
    public List<Product> list(Local local) {
        return repository.filterLoco(local);
    }

    @Override
    public List<Product> alcoholList(AlcoholType filterAlcohol){
        return repository.filterType(filterAlcohol);
    }

    @Override
    public List<Product> listByView() {
        return repository.findAll(Sort.by(Sort.Direction.DESC, "view"));
    }

    @Override
    public Product getProductInfo(Long productNo) {
        Optional<Product> maybeProduct = repository.findById(productNo);
        if(productNo.equals(Optional.empty())) {
            log.info("해당 상품을 가져올 수 없음.");
            return null;
        }
        Product product = maybeProduct.get();
        Integer cnt = 1;
        product.setView(product.getView() + cnt);
        repository.save(product);

        return product;
    }

    @Override
    public void registerProduct(List<MultipartFile> thumbnail, List<MultipartFile> fileList, ProductRequest productRequest) {

        // 1. product 저장
        Product product = new Product();
        product.setName(productRequest.getName());
        product.setBrand(productRequest.getBrand());
        product.setPrice(productRequest.getPrice());
        product.setDeliveryFee(productRequest.getDeliveryFee());

        //2. classfication 저장
        product.setClassification(registerClassification(productRequest.getLocal(), productRequest.getType()));

        //3. productInfo 저장
        // productInfo-> String thumbnailFileName,List<String> productImagesName,List<String> String taste, String subTitle,String description

        ProductInfo productInfo = new ProductInfo();
        productInfo.setTaste(productRequest.getTaste());
        productInfo.setSubTitle(productRequest.getSubTitle());
        productInfo.setDescription(productRequest.getDescription());


        // 실제 파일 frontend 이미지 폴더 경로에 저장
        try {
            //1. 썸네일 저장
            for (MultipartFile multipartFile: thumbnail) {
                log.info("requestUploadFilesWithText() - Make file: " + multipartFile.getOriginalFilename());
                UUID thumbnailRandomName = UUID.randomUUID(); ;
                String thumbnailReName = thumbnailRandomName + multipartFile.getOriginalFilename();

                //저장 경로 지정 + 파일네임
                FileOutputStream writer1 = new FileOutputStream("../ztz_web/src/assets/products/uploadImg/" + thumbnailReName);
                log.info("디렉토리에 파일 배치 성공!");

                //파일 저장(저장할때는 byte 형식으로 저장해야 해서 파라미터로 받은 multipartFile 파일들의 getBytes() 메소드 적용해서 저장하는 듯)
                writer1.write(multipartFile.getBytes());

                productInfo.setThumbnailFileName(thumbnailReName);

                writer1.close();
            }

            //2. 상품 상세사진 저장
                List<String> imageList = new ArrayList<>();

                for (MultipartFile multipartFile: fileList) {
                log.info("requestUploadFilesWithText() - Make file: " + multipartFile.getOriginalFilename());

                 UUID fileRandomName = UUID.randomUUID();
                 String fileReName = fileRandomName+multipartFile.getOriginalFilename();

                //저장 경로 지정 + 파일네임
                FileOutputStream writer2 = new FileOutputStream("../ztz_web/src/assets/products/uploadImg/" + fileReName);
                log.info("디렉토리에 파일 배치 성공!");

                //파일 저장(저장할때는 byte 형식으로 저장해야 해서 파라미터로 받은 multipartFile 파일들의 getBytes() 메소드 적용해서 저장하는 듯)
                writer2.write(multipartFile.getBytes());

                //이미지리스트 이름 저장
                imageList.add(fileReName);

                writer2.close();
            }
            productInfo.setProductImagesName(imageList);
            product.setProductInfo(productInfo);
            repository.save(product);

        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }


    }

    public Classification registerClassification(String localRequest, String typeRequest){ //ProductRequest productRequest
        String inputLocal = localRequest;
        String inputType = typeRequest;

        AlcoholType alcoholType = null;
        Local local = null;


        switch (inputLocal){
            case "서울경기":
                local = Local.SEOUL_GYEONGGI;
                break;
            case "강원":
                local = Local.GANGWON;
                break;
            case "전라":
                local = Local.JEONLA;
                break;
            case "충청":
                local = Local.CHUNGCHEONG;
                break;
            case "경상":
                local = Local.GYEONGSANG;
                break;
            case "제주":
                local = Local.JEJU;
                break;
        }

        switch (inputType){
            case "소주증류주":
                alcoholType = AlcoholType.SOJU_SPIRITS;
                break;
            case "리큐르":
                alcoholType = AlcoholType.LIQUEUR;
                break;
            case "막걸리":
                alcoholType = AlcoholType.MAKGEOLLI;
                break;
            case "약주청주":
                alcoholType = AlcoholType.YAKJU_CHEONGJU;
                break;
            case "과실주":
                alcoholType = AlcoholType.FRUITWINE;
                break;
            case "기타주류":
                alcoholType = AlcoholType.OTHER;
                break;
        }

       Classification classification = new Classification(alcoholType, local);

       return classification;
    }

    @Override
    public void modifyProduct(List<MultipartFile> thumbnail, List<MultipartFile> fileList, ProductModifyRequest productModifyRequest){

        Optional<Product> maybeProduct = repository.findById(productModifyRequest.getProductNo());
        if (maybeProduct.equals(Optional.empty())) {
            log.info("Can't modify product");
        }
        Product product = maybeProduct.get();

        // 1. product 저장
        product.setName(productModifyRequest.getName());
        product.setBrand(productModifyRequest.getBrand());
        product.setPrice(productModifyRequest.getPrice());
        product.setDeliveryFee(productModifyRequest.getDeliveryFee());

        //2. classfication 저장
        product.setClassification(registerClassification(productModifyRequest.getLocal(), productModifyRequest.getType()));

        //3. productInfo 저장
        // productInfo-> String thumbnailFileName,List<String> productImagesName,List<String> String taste, String subTitle,String description

        ProductInfo productInfo = new ProductInfo();
        productInfo.setTaste(productModifyRequest.getTaste());
        productInfo.setSubTitle(productModifyRequest.getSubTitle());
        productInfo.setDescription(productModifyRequest.getDescription());

        // 실제 파일 frontend 이미지 폴더 경로에 저장
        try {
            //1. 썸네일 변경 있을 시
            if(thumbnail!= null ){
                for (MultipartFile multipartFile: thumbnail) {
                    log.info("requestUploadFilesWithText() - Make file: " + multipartFile.getOriginalFilename());
                    int thumbnailRandomName = setRandomOrderNo.makeIntCustomRandom(1,100000);
                    String thumbnailReName = thumbnailRandomName + multipartFile.getOriginalFilename();

                    //저장 경로 지정 + 파일네임
                    FileOutputStream writer1 = new FileOutputStream("../ztz_web/src/assets/products/uploadImg/" + thumbnailReName);
                    log.info("디렉토리에 파일 배치 성공!");

                    //파일 저장(저장할때는 byte 형식으로 저장해야 해서 파라미터로 받은 multipartFile 파일들의 getBytes() 메소드 적용해서 저장하는 듯)
                    writer1.write(multipartFile.getBytes());

                    productInfo.setThumbnailFileName(thumbnailReName);

                    writer1.close();
                }
            //2. 썸네일 변경 없을 시
            }else{
                productInfo.setThumbnailFileName(product.getProductInfo().getThumbnailFileName());
            }

            //1. 상세사진 변경 있을 시
            if(fileList!= null){
                List<String> imageList = new ArrayList<>();

                for (MultipartFile multipartFile: fileList) {
                    log.info("requestUploadFilesWithText() - Make file: " + multipartFile.getOriginalFilename());

                    int fileRandomName = setRandomOrderNo.makeIntCustomRandom(1,100000);
                    String fileReName = fileRandomName+multipartFile.getOriginalFilename();

                    //저장 경로 지정 + 파일네임
                    FileOutputStream writer2 = new FileOutputStream("../ztz_web/src/assets/products/uploadImg/" + fileReName);
                    log.info("디렉토리에 파일 배치 성공!");

                    //파일 저장(저장할때는 byte 형식으로 저장해야 해서 파라미터로 받은 multipartFile 파일들의 getBytes() 메소드 적용해서 저장하는 듯)
                    writer2.write(multipartFile.getBytes());

                    //이미지리스트 이름 저장
                    imageList.add(fileReName);

                    writer2.close();
                }
                productInfo.setProductImagesName(imageList);
            //2. 상세사진 변경 없을 시
            }else {
                productInfo.setProductImagesName(product.getProductInfo().getProductImagesName());
            }

            product.setProductInfo(productInfo);
            repository.save(product);

        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public void remove(Long productNo){
        repository.deleteById(productNo);
    }
}
