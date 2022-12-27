package kr.eddi.ztz_process.service.products;

import kr.eddi.ztz_process.controller.products.request.ProductModifyRequest;
import kr.eddi.ztz_process.controller.products.request.ProductRequest;
import kr.eddi.ztz_process.entity.products.AlcoholType;
import kr.eddi.ztz_process.entity.products.Local;
import kr.eddi.ztz_process.entity.products.Product;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ProductsService {

    public List<Product> list();

    public List<Product> search(String keyword);
    public List<Product> list(Local local);
    public List<Product> alcoholList(AlcoholType filterAlcohol);
    public List<Product> listByView();
    public Product getProductInfo(Long productNo);

    public void registerProduct(List<MultipartFile> thumbnail, List<MultipartFile> fileList, ProductRequest productRequest);

    public void modifyProduct(List<MultipartFile> thumbnail, List<MultipartFile> fileList, ProductModifyRequest productModifyRequest);

    public void remove(Long productNo);

    public String checkMonthAlcohol(Long productNo);

    public List<Product> monthAlcoholList();
}
