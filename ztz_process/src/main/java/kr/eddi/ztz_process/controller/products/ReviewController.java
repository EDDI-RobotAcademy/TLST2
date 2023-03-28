package kr.eddi.ztz_process.controller.products;

import kr.eddi.ztz_process.controller.products.request.ReviewRequest;
import kr.eddi.ztz_process.entity.products.Review;
import kr.eddi.ztz_process.service.products.ReviewService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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

        reviewService.register(reviewRequest);
    }

    @PostMapping(value = "/registerWithImg", consumes = {
            MediaType.MULTIPART_FORM_DATA_VALUE,
            MediaType.APPLICATION_JSON_VALUE})
    public void registerWithImg(
            @RequestPart(value = "image") MultipartFile image,
            @RequestPart(value = "info") ReviewRequest reviewRequest) {

        reviewService.registerWithImg(reviewRequest, image);
    }

    @PostMapping("/read/{productNo}")
    public List<Review> reviewList(@PathVariable("productNo") Long productNo) {

        return reviewService.productReviewRead(productNo);
    }

    @PostMapping("/read/average/{productNo}")
    public List<Map<String,Object>> reviewAverage(@PathVariable("productNo") Long productNo) {

        return reviewService.reviewAverage(productNo);
    }

    @PostMapping("/read/myPage/{memberId}")
    public List<Review> memberReviewList(@PathVariable("memberId") Long memberId) {

        return reviewService.memberReviewRead(memberId);
    }

    @DeleteMapping("/delete/{reviewNo}")
    public void deleteReview (@PathVariable("reviewNo") Long reviewNo) {

        reviewService.deleteReview(reviewNo);
    }

    @PutMapping("/modify/{reviewNo}")
    public void modifyReview (@PathVariable("reviewNo") Long reviewNo,
                              @RequestBody ReviewRequest reviewRequest) {

        reviewService.modify(reviewNo, reviewRequest);
    }

    @ResponseBody
    @PutMapping(value = "/modifyWithImg/{reviewNo}", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE, MediaType.APPLICATION_JSON_VALUE})
    public void modifyWithImg(
            @PathVariable("reviewNo") Long reviewNo,
            @RequestPart(value = "image") MultipartFile image,
            @RequestPart(value = "info") ReviewRequest reviewRequest) {

        reviewService.modifyWithImg(reviewNo, reviewRequest, image);
    }
    
}
