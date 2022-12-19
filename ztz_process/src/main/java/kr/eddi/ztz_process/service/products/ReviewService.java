package kr.eddi.ztz_process.service.products;

import kr.eddi.ztz_process.controller.products.request.ReviewRequest;
import kr.eddi.ztz_process.entity.products.Review;

import java.util.List;

public interface ReviewService {

    public void register(ReviewRequest reviewRequest);

    public void registerWithImg(ReviewRequest reviewRequest, String thumbFileName);

    public List<Review> productReviewRead(Long productNo);

    public List<Review> memberReviewRead(Long memberId);


}
