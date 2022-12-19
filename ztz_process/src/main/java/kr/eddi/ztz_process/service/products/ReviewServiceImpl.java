package kr.eddi.ztz_process.service.products;

import kr.eddi.ztz_process.controller.products.request.ReviewRequest;
import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.entity.products.Product;
import kr.eddi.ztz_process.entity.products.ProductInfo;
import kr.eddi.ztz_process.entity.products.Review;
import kr.eddi.ztz_process.repository.member.MemberRepository;
import kr.eddi.ztz_process.repository.products.ProductsRepository;
import kr.eddi.ztz_process.repository.products.ReviewRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
public class ReviewServiceImpl implements ReviewService{

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private ProductsRepository productsRepository;

    @Override
    public void register(ReviewRequest reviewRequest) {
        Optional<Member> maybeMember = memberRepository.findById(reviewRequest.getMemberId());
        Member member = maybeMember.get();

        Optional<Product> maybeProduct = productsRepository.findById(reviewRequest.getProductNo());
        Product product = maybeProduct.get();
        Review review = Review.builder()
                .member(member)
                .product(product)
                .rate(reviewRequest.getRate())
                .content(reviewRequest.getContent())
                .build();
        reviewRepository.save(review);

    }

    @Override
    public void registerWithImg(ReviewRequest reviewRequest, String thumbnailFileName) {
        Optional<Member> maybeMember = memberRepository.findById(reviewRequest.getMemberId());
        Member member = maybeMember.get();

        Optional<Product> maybeProduct = productsRepository.findById(reviewRequest.getProductNo());
        Product product = maybeProduct.get();


        Review review = Review.builder()
                .member(member)
                .product(product)
                .rate(reviewRequest.getRate())
                .content(reviewRequest.getContent())
                .thumbnailFileName(thumbnailFileName)
                .build();
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
}
