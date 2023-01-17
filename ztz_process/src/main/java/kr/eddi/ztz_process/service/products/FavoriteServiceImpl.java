package kr.eddi.ztz_process.service.products;


import kr.eddi.ztz_process.controller.products.response.FavoriteResponse;
import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.entity.products.Favorite;
import kr.eddi.ztz_process.entity.products.Product;
import kr.eddi.ztz_process.repository.member.MemberRepository;
import kr.eddi.ztz_process.repository.products.FavoriteRepository;
import kr.eddi.ztz_process.repository.products.ProductsRepository;
import kr.eddi.ztz_process.service.security.RedisService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

import static kr.eddi.ztz_process.utility.order.validationToken.validationToken;

@Slf4j
@Service
public class FavoriteServiceImpl implements FavoriteService {

    @Autowired
    FavoriteRepository favoriteRepository;

    @Autowired
    ProductsRepository productRepository;

    @Autowired
    MemberRepository memberRepository;

    @Autowired
    private RedisService redisService;


    @Override
    public FavoriteResponse favoriteStatus(Long memberId, Long productNo, String favoriteType){
        final String FAVORITE_CHECK = "favoriteCheck";
        final String FAVORITE_LIKE = "favoriteLike";

        final Integer countFavorite = 1;

        FavoriteResponse favoriteResponse = new FavoriteResponse();

        log.info("좋아요 서비스 임플: " + memberId + productNo + favoriteType);

        Optional<Product> maybeProduct = productRepository.findById(productNo);
        Product product = maybeProduct.get();
        Integer favoriteStatus = 0;



        Optional<Favorite> maybeFavorite = favoriteRepository.findByProductAndMember(productNo, memberId);

        //1. 비로그인회원이 누른 경우
        if(memberId == null || memberId.equals(null)){
            favoriteStatus = product.getFavoriteNum();
            favoriteResponse.setFavoriteNum(favoriteStatus);
            favoriteResponse.setProductFavoriteFlag(false);
            return favoriteResponse;

       //1. 로그인회원이 누른경우
        } else {
            Optional<Member> maybeMember = memberRepository.findById(memberId) ;
            Member member = maybeMember.get();

            // 2. 좋아요/ 좋아요취소가 클릭된 경우
            // (1) 해당 멤버가 해당 게시글 추천한 이력이 없는 경우(= 쿼리결과가 empty가 나오는 경우)
            if(maybeFavorite.equals(Optional.empty())) {
                Favorite firstLike = new Favorite();

                switch(favoriteType){
                    case FAVORITE_LIKE:
                        //1) 좋아요 반영
                        favoriteStatus = product.getFavoriteNum() + countFavorite;
                        product.setFavoriteNum(favoriteStatus);
                        productRepository.save(product);
                        firstLike.setProduct(product);
                        firstLike.setMember(member);
                        firstLike.setLikeFlag(true);
                        favoriteRepository.save(firstLike);

                        favoriteResponse.setFavoriteNum(favoriteStatus);
                        favoriteResponse.setProductFavoriteFlag(true);
                        return favoriteResponse;

                    case FAVORITE_CHECK:
                        //2) 좋아요 상태 조회
                        favoriteStatus = product.getFavoriteNum();
                        favoriteResponse.setFavoriteNum(favoriteStatus);
                        favoriteResponse.setProductFavoriteFlag(false);
                        return favoriteResponse;
                }

            } else {
                // (2) 해당 멤버가 좋아요 이력이 있는 경우
                Favorite favoriteIsPresent = maybeFavorite.get();

                switch(favoriteType){
                    case FAVORITE_LIKE:
                        // 1) 좋아요 플래그가 false인경우 -> 좋아요 반영
                        if(!favoriteIsPresent.getLikeFlag()){
                            favoriteStatus = product.getFavoriteNum() + countFavorite;
                            product.setFavoriteNum(favoriteStatus);
                            productRepository.save(product);
                            favoriteIsPresent.setLikeFlag(true);
                            favoriteRepository.save(favoriteIsPresent);

                            favoriteResponse.setFavoriteNum(favoriteStatus);
                            favoriteResponse.setProductFavoriteFlag(true);

                            return favoriteResponse;
                        } else {
                            // 2) 좋아요 플래그가 true인경우 -> 좋아요 취소됨

                            favoriteStatus = product.getFavoriteNum() - countFavorite;
                            product.setFavoriteNum(favoriteStatus);
                            favoriteIsPresent.setLikeFlag(false);
                            favoriteRepository.save(favoriteIsPresent);
                            productRepository.save(product);

                            favoriteResponse.setFavoriteNum(favoriteStatus);
                            favoriteResponse.setProductFavoriteFlag(false);

                            return favoriteResponse;
                        }

                    case FAVORITE_CHECK:
                        // 3) 좋아요 상태 조회
                        if(!favoriteIsPresent.getLikeFlag()){
                            favoriteStatus = product.getFavoriteNum();
                            favoriteResponse.setFavoriteNum(favoriteStatus);
                            favoriteResponse.setProductFavoriteFlag(false);
                            return favoriteResponse;
                        } else{
                            favoriteStatus = product.getFavoriteNum();
                            favoriteResponse.setFavoriteNum(favoriteStatus);
                            favoriteResponse.setProductFavoriteFlag(true);
                            return favoriteResponse;
                        }

                }
            }
        }


        return favoriteResponse;
    }

    @Override
    public List<Favorite> myFavoriteProductList(String token){
        String returnToken = validationToken(token);
        Long id = redisService.getValueByKey(returnToken);
        log.info("짬한상품 조회 멤버 아이디: " +id);
        log.info("짬한상품 조회 리스트" + favoriteRepository.findByFavoriteByMemberId(id).toString() );
        return favoriteRepository.findByFavoriteByMemberId(id);
    }
}

