package kr.eddi.ztz_process.service.products;

import kr.eddi.ztz_process.controller.products.request.ReviewRequest;
import kr.eddi.ztz_process.entity.products.Review;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface ReviewService {

    public void register(ReviewRequest reviewRequest);

    public void registerWithImg(ReviewRequest reviewRequest, String thumbFileName);

    public List<Review> productReviewRead(Long productNo);

    public List<Review> memberReviewRead(Long memberId);

    public void deleteReview(Long reviewNo);

    public void modify(Long reviewNo, ReviewRequest reviewRequest);

    public void modifyWithImg(Long reviewNo, ReviewRequest reviewRequest, MultipartFile image);

    public List<Map<String,Object>> reviewAverage(Long ProductNo);
}
