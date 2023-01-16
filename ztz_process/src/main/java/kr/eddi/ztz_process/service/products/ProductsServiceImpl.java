package kr.eddi.ztz_process.service.products;

import kr.eddi.ztz_process.controller.products.request.ProductLocalAndTypeRequest;
import kr.eddi.ztz_process.controller.products.request.ProductModifyRequest;
import kr.eddi.ztz_process.controller.products.request.ProductRequest;
import kr.eddi.ztz_process.entity.products.*;
import kr.eddi.ztz_process.repository.products.ProductsRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

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
    public List<Product> list(ProductLocalAndTypeRequest productLocalAndTypeRequest) {
        try{
            AlcoholType alcoholType = AlcoholType.valueOfAlcoholName(productLocalAndTypeRequest.getAlcoholType());
            Local local = Local.valueOfLocalName(productLocalAndTypeRequest.getLocalName());
            List<Product> ProductList = repository.findByLocalAndType(alcoholType,local);

            if(ProductList.equals(Optional.empty())){
                log.info("해당 상품이 존재 하지 않습니다.");
                return null;
            }else {
                return ProductList;
            }
        }catch (Exception e){
            System.out.println("오류" + e);
            return null;
        }

    }

    @Override
    public List<Product> search(String keyword){
        return repository.findSearchProduct(keyword,keyword);
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

    public List<Product> recommendListByView() {
        int limit = 5;
        List<Product> tmpList =  repository.findAll(Sort.by(Sort.Direction.DESC, "view"));
        List<Product> productList = new ArrayList<>();
        for (int i = 0; i < limit; i++) {
            productList.add(tmpList.get(i));
        }
        return productList;
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

        LocalDateTime now = LocalDateTime.now(ZoneId.of("Asia/Seoul"));
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");

        // 실제 파일 frontend 이미지 폴더 경로에 저장
        try {
            //1. 썸네일 저장
            for (MultipartFile multipartFile: thumbnail) {
                log.info("requestUploadFilesWithText() - Make file: " + multipartFile.getOriginalFilename());
                String thumbnailRandomName = now.format(dtf);
                String thumbnailReName = 't'+thumbnailRandomName + multipartFile.getOriginalFilename();

                //저장 경로 지정 + 파일네임
                FileOutputStream writer1 = new FileOutputStream("../ztz_web/src/assets/products/uploadImg/" + thumbnailReName);
                FileOutputStream appWriter1 = new FileOutputStream("../ztz_app/assets/images/uploadImg/" + thumbnailReName);
                log.info("디렉토리에 파일 배치 성공!");

                //파일 저장(저장할때는 byte 형식으로 저장해야 해서 파라미터로 받은 multipartFile 파일들의 getBytes() 메소드 적용해서 저장하는 듯)
                writer1.write(multipartFile.getBytes());
                appWriter1.write(multipartFile.getBytes());

                productInfo.setThumbnailFileName(thumbnailReName);

                writer1.close();
                appWriter1.close();
            }

            //2. 상품 상세사진 저장
                List<String> imageList = new ArrayList<>();

                for (MultipartFile multipartFile: fileList) {
                log.info("requestUploadFilesWithText() - Make file: " + multipartFile.getOriginalFilename());

                 String fileRandomName = now.format(dtf);
                 String fileReName = 'f' + fileRandomName + multipartFile.getOriginalFilename();

                FileOutputStream writer2 = new FileOutputStream("../ztz_web/src/assets/products/uploadImg/" + fileReName);
                FileOutputStream appWriter2 = new FileOutputStream("../ztz_app/assets/images/uploadImg/" + fileReName);
                log.info("디렉토리에 파일 배치 성공!");

                writer2.write(multipartFile.getBytes());
                appWriter2.write(multipartFile.getBytes());

                //이미지리스트 이름 저장
                imageList.add(fileReName);

                writer2.close();
                appWriter2.close();
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

        LocalDateTime now = LocalDateTime.now(ZoneId.of("Asia/Seoul"));
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");

        // 실제 파일 frontend 이미지 폴더 경로에 저장 - 이전에 저장된 원본 파일 삭제

        try {
            //1. 썸네일 변경 있을 시
            if(thumbnail!= null ){

                for (MultipartFile multipartFile: thumbnail) {
                    log.info("requestUploadFilesWithText() - Make file: " + multipartFile.getOriginalFilename());
                    String thumbnailRandomName = now.format(dtf);
                    String thumbnailReName = 't' + thumbnailRandomName + multipartFile.getOriginalFilename();

                    //저장 경로 지정 + 파일네임
                    FileOutputStream writer1 = new FileOutputStream("../ztz_web/src/assets/products/uploadImg/" + thumbnailReName);
                    FileOutputStream appWriter1 = new FileOutputStream("../ztz_app/assets/images/uploadImg/" + thumbnailReName);

                    log.info("디렉토리에 파일 배치 성공!");

                    writer1.write(multipartFile.getBytes());
                    appWriter1.write(multipartFile.getBytes());

                    productInfo.setThumbnailFileName(thumbnailReName);

                    writer1.close();
                    appWriter1.close();
                }

                // 이전에 저장된 원본 파일 삭제
                String oldThumbnailName = product.getProductInfo().getThumbnailFileName();

                File webFile = new File("../ztz_web/src/assets/products/uploadImg/"
                        + URLDecoder.decode(oldThumbnailName, "UTF-8"));
                webFile.delete();
                File appFile = new File("../ztz_app/assets/images/uploadImg/"
                        + URLDecoder.decode(oldThumbnailName, "UTF-8"));
                appFile.delete();


            //2. 썸네일 변경 없을 시
            }else{
                productInfo.setThumbnailFileName(product.getProductInfo().getThumbnailFileName());
            }

            //1. 상세사진 변경 있을 시
            if(fileList!= null){

                List<String> imageList = new ArrayList<>();

                for (MultipartFile multipartFile: fileList) {
                    log.info("requestUploadFilesWithText() - Make file: " + multipartFile.getOriginalFilename());
                    String fileRandomName = now.format(dtf);
                    String fileReName = 'f' + fileRandomName + multipartFile.getOriginalFilename();

                    //저장 경로 지정 + 파일네임
                    FileOutputStream writer2 = new FileOutputStream("../ztz_web/src/assets/products/uploadImg/" + fileReName);
                    FileOutputStream appWriter2 = new FileOutputStream("../ztz_app/assets/images/uploadImg/" + fileReName);
                    log.info("디렉토리에 파일 배치 성공!");

                    writer2.write(multipartFile.getBytes());
                    appWriter2.write(multipartFile.getBytes());

                    //이미지리스트 이름 저장
                    imageList.add(fileReName);

                    writer2.close();
                    appWriter2.close();
                }
                productInfo.setProductImagesName(imageList);

                // 이전에 저장된 원본 파일은 삭제
                List<String> oldProductFileName = product.getProductInfo().getProductImagesName();

                for (String productFileName : oldProductFileName) {
                    File webProductFile = new File("../ztz_web/src/assets/products/uploadImg/"
                            + URLDecoder.decode(productFileName, "UTF-8"));
                    webProductFile.delete();
                    File appProductFile = new File("../ztz_app/assets/images/uploadImg/"
                            + URLDecoder.decode(productFileName, "UTF-8"));
                    appProductFile.delete();
                }

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

    public void remove(Long productNo) {
        Optional<Product> maybeProduct = repository.findById(productNo);
        String thumbnailFileName = maybeProduct.get().getProductInfo().getThumbnailFileName();
        List<String> maybeProductFileName = maybeProduct.get().getProductInfo().getProductImagesName();

        try {
            File webFile = new File("../ztz_web/src/assets/products/uploadImg/"
                    + URLDecoder.decode(thumbnailFileName, "UTF-8"));
            webFile.delete();
            File appFile = new File("../ztz_app/assets/images/uploadImg/"
                    + URLDecoder.decode(thumbnailFileName, "UTF-8"));
            appFile.delete();

            for (String productFileName : maybeProductFileName) {
                File webProductFile = new File("../ztz_web/src/assets/products/uploadImg/"
                        + URLDecoder.decode(productFileName, "UTF-8"));
                webProductFile.delete();
                File appProductFile = new File("../ztz_app/assets/images/uploadImg/"
                        + URLDecoder.decode(productFileName, "UTF-8"));
                appProductFile.delete();
            }

        } catch (Exception e) {
            log.info("원본 파일 삭제 오류");
            e.printStackTrace();
        }

        repository.deleteById(productNo);
    }

    public String checkMonthAlcohol(Long productNo){
        double discountRate = 0.9;
        String msg = "";

        Optional<Product> maybeProduct = repository.findById(productNo);
        if (maybeProduct.equals(Optional.empty())) {
            log.info("Can't find product");
        }
        Product product = maybeProduct.get();

        if(product.getMonthAlcoholCheck()){
            product.setMonthAlcoholCheck(false);
            product.setPrice((int) (product.getPrice() / discountRate));
            msg ="이달의 술 등록이 해제되었습니다.";
        }else{
            product.setMonthAlcoholCheck(true);
            product.setPrice((int) (product.getPrice() * discountRate));
            msg ="이달의 술로 등록되었습니다.";
        }

        repository.save(product);

        return msg;
    }

    public List<Product> monthAlcoholList(){
        return repository.findMonthAlcoholProducts();
    }

    @Override
    public List<Product> monthLocalList(Local local) {
        return repository.findMonthByLocal(local);
    }

    @Override
    public List<Product> bestLocalList(Local local) {
        return repository.findBestByLocal(local);
    }

    @Override
    public List<Product> bestLocalAndAlcoholList(ProductLocalAndTypeRequest request) {
        try {
            AlcoholType alcoholType = AlcoholType.valueOfAlcoholName(request.getAlcoholType());
            Local local = Local.valueOfLocalName(request.getLocalName());
            List<Product> productList = repository.findBestByLocalAndType(alcoholType, local);

            if (productList.equals(Optional.empty())) {
                log.info("해당하는 상품을 찾을 수 없습니다.");
                return null;
            } else {
                return productList;
            }
        } catch (Exception e) {
            log.info("베스트 상품 지역 알콜 조회 오류" + e);
            return null;
        }
    }

    @Override
    public List<Product> bestAlcoholList(AlcoholType alcoholType) {
        return repository.findBestByAlcoholType(alcoholType);
    }


}
