package kr.eddi.ztz_process.service.products;

import kr.eddi.ztz_process.entity.products.Local;
import kr.eddi.ztz_process.entity.products.Product;
import kr.eddi.ztz_process.repository.products.ProductsRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

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
    public List<Product> list(Local local) {
        return repository.filterLoco(local);
    }
    @Override
    public Product getProductInfo(Long productNo) {
        Optional<Product> maybeProduct = repository.findById(productNo);
        if(productNo.equals(Optional.empty())) {
            log.info("해당 상품을 가져올 수 없음.");
            return null;
        }
        return maybeProduct.get();
    }
}
