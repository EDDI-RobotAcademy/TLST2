package kr.eddi.ztz_process.service.products;

import com.siot.IamportRestClient.response.payco.OrderStatus;
import kr.eddi.ztz_process.controller.products.request.ReviewRequest;
import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.entity.order.OrderInfo;
import kr.eddi.ztz_process.entity.order.PaymentState;
import kr.eddi.ztz_process.entity.products.Product;
import kr.eddi.ztz_process.entity.products.Review;
import kr.eddi.ztz_process.repository.member.MemberRepository;
import kr.eddi.ztz_process.repository.order.OrderInfoRepository;
import kr.eddi.ztz_process.repository.products.ProductsRepository;
import kr.eddi.ztz_process.repository.products.ReviewRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Slf4j
@Service
public class ReviewServiceImpl implements ReviewService{

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private ProductsRepository productsRepository;

    @Autowired
    private OrderInfoRepository orderInfoRepository;
    @Override
    public void register(ReviewRequest reviewRequest) {
        Optional<Member> maybeMember = memberRepository.findById(reviewRequest.getMemberId());
        Member member = maybeMember.get();

        Optional<OrderInfo> maybeOrderInfo = orderInfoRepository.findById(reviewRequest.getOrderId());
        OrderInfo orderInfo = maybeOrderInfo.get();

        Optional<Product> maybeProduct = productsRepository.findById(reviewRequest.getProductNo());
        Product product = maybeProduct.get();
        Review review = Review.builder()
                .member(member)
                .product(product)
                .rate(reviewRequest.getRate())
                .content(reviewRequest.getContent())
                .orderInfo(orderInfo)
                .build();

        orderInfo.setOrderState(PaymentState.WRITE_REVIEW);
        orderInfoRepository.save(orderInfo);
        reviewRepository.save(review);

    }

    @Override
    public void registerWithImg(ReviewRequest reviewRequest, String thumbnailFileName) {
        Optional<Member> maybeMember = memberRepository.findById(reviewRequest.getMemberId());
        Member member = maybeMember.get();

        Optional<OrderInfo> maybeOrderInfo = orderInfoRepository.findById(reviewRequest.getOrderId());
        OrderInfo orderInfo = maybeOrderInfo.get();

        Optional<Product> maybeProduct = productsRepository.findById(reviewRequest.getProductNo());
        Product product = maybeProduct.get();


        Review review = Review.builder()
                .member(member)
                .product(product)
                .rate(reviewRequest.getRate())
                .content(reviewRequest.getContent())
                .thumbnailFileName(thumbnailFileName)
                .orderInfo(orderInfo)
                .build();

        orderInfo.setOrderState(PaymentState.WRITE_REVIEW);
        orderInfoRepository.save(orderInfo);

        reviewRepository.save(review);
    }

    @Override
    public List<Review> productReviewRead(Long productNo) {
        return reviewRepository.findByProductNo(productNo);
    }

    @Override
    public List<Review> memberReviewRead(Long memberId) {
        return reviewRepository.findByMemberId(memberId);
    }

    @Override
    public void deleteReview(Long reviewNo) {
        reviewRepository.deleteById(reviewNo);
    }

    @Override
    public void modify(Long reviewNo, ReviewRequest reviewRequest) {
        Optional<Review> maybeReview = reviewRepository.findById(reviewNo);
        Review review = maybeReview.get();

        review.setRate(reviewRequest.getRate());
        review.setContent(reviewRequest.getContent());

        reviewRepository.save(review);
    }

    @Override
    public void modifyWithImg(Long reviewNo, ReviewRequest reviewRequest, String thumbnailFileName) {
        Optional<Review> maybeReview = reviewRepository.findById(reviewNo);
        Review review = maybeReview.get();

        review.setRate(reviewRequest.getRate());
        review.setContent(reviewRequest.getContent());
        review.setThumbnailFileName(thumbnailFileName);

        reviewRepository.save(review);
    }

    @Override
    public List<Map<String, Object>> reviewAverage(Long productNo) {
        List<Review> maybeReview = reviewRepository.findByProductNo(productNo);
        if(maybeReview == null){
            return null;
        }else {
            Double average = 0.0;
            Integer reviewCnt = maybeReview.size();
            for (int i = 0; i < maybeReview.size(); i++) {
                average += maybeReview.get(i).getRate();
            }
            average = average/reviewCnt;
            List<Map<String , Object>> productReview = new ArrayList<>();
            Map<String , Object> reviewAverage = new HashMap<>();
            reviewAverage.put("average",average);
            reviewAverage.put("reviewCnt", reviewCnt);
            productReview.add(reviewAverage);

            System.out.println(reviewAverage.toString());
            return productReview;
        }
    }


}
