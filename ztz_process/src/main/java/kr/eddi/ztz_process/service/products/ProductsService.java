package kr.eddi.ztz_process.service.products;

import kr.eddi.ztz_process.entity.products.Local;
import kr.eddi.ztz_process.entity.products.Product;

import java.util.List;

public interface ProductsService {

    public List<Product> list();
    public List<Product> list(Local local);
    public Product getProductInfo(Long productNo);
}
