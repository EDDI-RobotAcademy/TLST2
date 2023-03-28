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

        Optional<Product> maybeProduct = productRepository.findById(productNo);
        Product product = maybeProduct.get();
        Integer favoriteStatus = 0;

        Optional<Favorite> maybeFavorite = favoriteRepository.findByProductAndMember(productNo, memberId);

        if(memberId == null || memberId.equals(null)){
            favoriteStatus = product.getFavoriteNum();
            favoriteResponse.setFavoriteNum(favoriteStatus);
            favoriteResponse.setProductFavoriteFlag(false);
            return favoriteResponse;

        } else {

            Optional<Member> maybeMember = memberRepository.findById(memberId) ;
            Member member = maybeMember.get();

            if(maybeFavorite.equals(Optional.empty())) {
                Favorite firstLike = new Favorite();

                switch(favoriteType){
                    case FAVORITE_LIKE:
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
                        favoriteStatus = product.getFavoriteNum();
                        favoriteResponse.setFavoriteNum(favoriteStatus);
                        favoriteResponse.setProductFavoriteFlag(false);
                        return favoriteResponse;
                }

            } else {
                Favorite favoriteIsPresent = maybeFavorite.get();

                switch(favoriteType){
                    case FAVORITE_LIKE:
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
        return favoriteRepository.findByFavoriteByMemberId(id);
    }
}

