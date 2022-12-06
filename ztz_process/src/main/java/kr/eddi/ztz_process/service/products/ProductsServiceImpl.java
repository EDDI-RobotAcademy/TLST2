package kr.eddi.ztz_process.service.products;

import kr.eddi.ztz_process.entity.products.Local;
import kr.eddi.ztz_process.entity.products.Product;
import kr.eddi.ztz_process.repository.products.ProductsRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

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
}
