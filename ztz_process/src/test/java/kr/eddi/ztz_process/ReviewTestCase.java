package kr.eddi.ztz_process;

import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.entity.products.Product;
import kr.eddi.ztz_process.entity.products.Review;
import kr.eddi.ztz_process.repository.member.MemberRepository;
import kr.eddi.ztz_process.repository.products.ProductsRepository;
import kr.eddi.ztz_process.repository.products.ReviewRepository;
import kr.eddi.ztz_process.service.products.ReviewService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Optional;

@SpringBootTest
public class ReviewTestCase {

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private ProductsRepository productsRepository;

    @Autowired
    private ReviewService service;
    @Test
    void buildReview() {
        Optional<Member> maybeMember = memberRepository.findById((long) 1);
        Member member = maybeMember.get();

        Optional<Product> maybeProduct = productsRepository.findById((long)2);
        Product product = maybeProduct.get();

//        Review review = Review.builder()
//                            .content("빌더 사용 리뷰").member(member).product(product).rate(5.0).thumbFileName("pd_01.png").build();
//        reviewRepository.save(review);

    }

    @Test
    void reviewAveTest(){
        service.reviewAverage((long)4);
    }
}
