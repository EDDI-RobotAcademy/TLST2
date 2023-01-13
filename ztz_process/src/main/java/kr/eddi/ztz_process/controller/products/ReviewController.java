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
import java.util.Map;

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

    @PostMapping(value = "/registerWithImg", consumes = {
            MediaType.MULTIPART_FORM_DATA_VALUE,
            MediaType.APPLICATION_JSON_VALUE})
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
                    "../ztz_web/src/assets/products/uploadImg/" + image.getOriginalFilename()
            );
            FileOutputStream appWriter = new FileOutputStream(
                    "../ztz_app/assets/images/uploadImg/" + image.getOriginalFilename()
            );

            log.info("디렉토리에 파일 배치 성공");

            writer.write(image.getBytes());
            appWriter.write(image.getBytes());
            writer.close();
            appWriter.close();
        } catch (FileNotFoundException e) {
            throw new RuntimeException((e));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        reviewService.registerWithImg(reviewRequest, thumbnailFileName);
    }

    @PostMapping("/read/{productNo}")
    public List<Review> reviewList(@PathVariable("productNo") Long productNo) {
        log.info(productNo + "상품의 리뷰 읽기");

        return reviewService.productReviewRead(productNo);
    }

    @PostMapping("/read/average/{productNo}")
    public List<Map<String,Object>> reviewAverage(@PathVariable("productNo") Long productNo) {
        log.info(productNo + "상품의 리뷰 평균");

        return reviewService.reviewAverage(productNo);
    }

    @PostMapping("/read/myPage/{memberId}")
    public List<Review> memberReviewList(@PathVariable("memberId") Long memberId) {
        log.info(memberId + "번 멤버의 리뷰 읽기");

        return reviewService.memberReviewRead(memberId);
    }

    @DeleteMapping("/delete/{reviewNo}")
    public void deleteReview (@PathVariable("reviewNo") Long reviewNo) {
        log.info(reviewNo + "번의 리뷰 삭제");

        reviewService.deleteReview(reviewNo);
    }

    @PutMapping("/modify/{reviewNo}")
    public void modifyReview (@PathVariable("reviewNo") Long reviewNo,
                              @RequestBody ReviewRequest reviewRequest) {
        log.info(reviewNo + "번의 리뷰 수정");

        reviewService.modify(reviewNo, reviewRequest);
    }

    @ResponseBody
    @PutMapping(value = "/modifyWithImg/{reviewNo}", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE, MediaType.APPLICATION_JSON_VALUE})
    public void modifyWithImg(
            @PathVariable("reviewNo") Long reviewNo,
            @RequestPart(value = "image") MultipartFile image,
            @RequestPart(value = "info") ReviewRequest reviewRequest) {

        log.info(reviewNo + "번의 리뷰 수정");
        log.info("파일 리스트" + image);
        log.info("파일 정보" + reviewRequest);

        String thumbnailFileName = image.getOriginalFilename();

        try {
            log.info("requestUploadFilesWitText() - Make file: " +
                    image.getOriginalFilename());
            FileOutputStream writer = new FileOutputStream(
                    "../ztz_web/src/assets/products/uploadImg/" + image.getOriginalFilename()
            );

            FileOutputStream appWriter = new FileOutputStream(
                    "../ztz_app/assets/images/uploadImg/" + image.getOriginalFilename()
            );
            log.info("디렉토리에 파일 배치 성공");

            writer.write(image.getBytes());
            appWriter.write(image.getBytes());

            writer.close();
            appWriter.close();

        } catch (FileNotFoundException e) {
            throw new RuntimeException((e));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        reviewService.modifyWithImg(reviewNo, reviewRequest, thumbnailFileName);
    }
    
}
