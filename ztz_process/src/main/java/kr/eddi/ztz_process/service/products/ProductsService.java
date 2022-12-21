package kr.eddi.ztz_process.service.products;

import kr.eddi.ztz_process.controller.products.request.ProductRequest;
import kr.eddi.ztz_process.entity.products.Local;
import kr.eddi.ztz_process.entity.products.Product;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ProductsService {

    public List<Product> list();
    public List<Product> list(Local local);
    public Product getProductInfo(Long productNo);

    public void registerProduct(List<MultipartFile> thumbnail, List<MultipartFile> fileList, ProductRequest productRequest);

}
