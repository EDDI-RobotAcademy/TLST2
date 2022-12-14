package kr.eddi.ztz_process.controller.products;

import kr.eddi.ztz_process.controller.products.request.ReviewRequest;
import kr.eddi.ztz_process.entity.products.Review;
import kr.eddi.ztz_process.service.products.ReviewService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("ztz/products/review")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @PostMapping("/register")
    public void reviewRegister(@RequestBody ReviewRequest reviewRequest) {
        log.info("reviewRegister()");

        reviewService.register(reviewRequest);
    }

    @ResponseBody
    @PostMapping(value = "/registerWithImg", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE, MediaType.APPLICATION_JSON_VALUE})
    public void registerWithImg(
            @RequestPart(value = "image") MultipartFile image,
            @RequestPart(value = "info") ReviewRequest reviewRequest) {
        log.info("파일리스트" + image);
        log.info("파일 정보" + reviewRequest);
        String thumbnailFileName = image.getOriginalFilename();

        try {
            log.info("requestUploadFilesWitText() - Make file: " +
                    image.getOriginalFilename());
            FileOutputStream writer = new FileOutputStream(
                    "C:/TLST2/ztz_web/src/assets/products/uploadImg/" + image.getOriginalFilename()
            );

            log.info("디렉토리에 파일 배치 성공");

            writer.write(image.getBytes());

            writer.close();

        } catch (FileNotFoundException e) {
            throw new RuntimeException((e));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        reviewService.registerWithImg(reviewRequest, thumbnailFileName);
    }

    @PostMapping("/read/{productNo}")
    public List<Review> reviewList(@PathVariable("productNo") Long productNo) {
        log.info(productNo + "의 리뷰 읽기");

        return reviewService.read(productNo);
    }
}
