package kr.eddi.ztz_process.controller.products;

import kr.eddi.ztz_process.entity.products.Product;
import kr.eddi.ztz_process.service.products.ProductsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@Slf4j
@RestController
@RequestMapping("/products")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ProductsController {
    @Autowired
    ProductsService productsService;
    @GetMapping(path = "/list")
    public List<Product> productsList() {
        return productsService.list();
    }

}
