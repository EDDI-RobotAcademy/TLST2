package kr.eddi.ztz_process.service.products;

import kr.eddi.ztz_process.controller.products.request.ProductLocalAndTypeRequest;
import kr.eddi.ztz_process.controller.products.request.ProductModifyRequest;
import kr.eddi.ztz_process.controller.products.request.ProductRequest;
import kr.eddi.ztz_process.entity.products.AlcoholType;
import kr.eddi.ztz_process.entity.products.Local;
import kr.eddi.ztz_process.entity.products.Product;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ProductsService {

    public List<Product> list();
    public List<Product> list(ProductLocalAndTypeRequest productLocalAndTypeForm);
    public List<Product> search(String keyword);
    public List<Product> list(Local local);
    public List<Product> alcoholList(AlcoholType filterAlcohol);
    public List<Product> listByView();
    public List<Product> recommendListByView();

    public List<Product> listByFavorite();

    public Product getProductInfo(Long productNo);

    public void registerProduct(List<MultipartFile> thumbnail, List<MultipartFile> fileList, ProductRequest productRequest);

    public void modifyProduct(List<MultipartFile> thumbnail, List<MultipartFile> fileList, ProductModifyRequest productModifyRequest);

    public void remove(Long productNo);

    public String checkMonthAlcohol(Long productNo);

    public List<Product> monthAlcoholList();
    public List<Product> monthLocalList(Local local);
    public List<Product> bestLocalList(Local local);

    public List<Product> bestLocalAndAlcoholList(ProductLocalAndTypeRequest request);

    public List<Product> bestAlcoholList(AlcoholType alcoholType);

    public List<Product> favoriteLocalList(Local local);

    public List<Product> favoriteLocalAndAlcoholList(ProductLocalAndTypeRequest request);

    public List<Product> favoriteAlcoholList(AlcoholType alcoholType);


    //페이지 네이션
    public List<Product> firstPageProduct();

    public List<Product> nextPageProduct(Long productNo);

    public List<Product> firstPageSearchProduct(String keyword);

    public List<Product> nextPageSearchProduct(Long productNo , String keyword);

    public List<Product> firstPageLocalProduct(Local local);

    public List<Product> nextPageLocalProduct(Long productNo ,Local local);

    public List<Product> firstPageAlcoholTypeProduct(AlcoholType alcoholType);

    public List<Product> nextPageAlcoholTypeProduct(Long productNo ,AlcoholType alcoholType);

    public List<Product> firstPageAlcoholTypeAndLocalProduct(AlcoholType alcoholType , Local local);

    public List<Product> nextPageAlcoholTypeAndLocalProduct(Long productNo ,AlcoholType alcoholType , Local local);
}
