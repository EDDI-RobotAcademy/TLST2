package kr.eddi.ztz_process.controller.products;

import kr.eddi.ztz_process.entity.products.Local;
import kr.eddi.ztz_process.entity.products.Product;
import kr.eddi.ztz_process.service.products.ProductsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@Slf4j
@RestController
@RequestMapping("ztz/products")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ProductsController {

    @Autowired
    ProductsService productsService;

    @GetMapping(path = "/list")
    public List<Product> productsList() {
        return productsService.list();
    }
    @GetMapping(path = "/list/{localName}")
    public List<Product> productsList(@PathVariable("localName") String localName) {
        String tmp = localName;
        Local filterLocal = Local.valueOfLocalName(tmp);

        return productsService.list(filterLocal);
    }
}
