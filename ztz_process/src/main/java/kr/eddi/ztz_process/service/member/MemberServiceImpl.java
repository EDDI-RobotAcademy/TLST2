package kr.eddi.ztz_process.service.member;

import jakarta.persistence.Basic;
import kr.eddi.ztz_process.entity.boards.QuestionBoard;
import kr.eddi.ztz_process.entity.boards.QuestionComment;
import kr.eddi.ztz_process.entity.member.*;
import kr.eddi.ztz_process.entity.order.Cart;
import kr.eddi.ztz_process.entity.order.Item;
import kr.eddi.ztz_process.entity.order.OrderInfo;
import kr.eddi.ztz_process.entity.order.Payment;
import kr.eddi.ztz_process.entity.products.Favorite;
import kr.eddi.ztz_process.entity.products.Review;
import kr.eddi.ztz_process.entity.tour.Reservation;
import kr.eddi.ztz_process.repository.boards.QuestionCommentRepository;
import kr.eddi.ztz_process.repository.boards.QuestionRepository;
import kr.eddi.ztz_process.repository.member.*;
import kr.eddi.ztz_process.repository.order.CartRepository;
import kr.eddi.ztz_process.repository.order.ItemRepository;
import kr.eddi.ztz_process.repository.order.OrderInfoRepository;
import kr.eddi.ztz_process.repository.order.PaymentRepository;
import kr.eddi.ztz_process.repository.products.FavoriteRepository;
import kr.eddi.ztz_process.repository.products.ReviewRepository;
import kr.eddi.ztz_process.repository.tour.ReservationRepository;
import kr.eddi.ztz_process.service.member.request.MemberAddressRequest;
import kr.eddi.ztz_process.service.member.request.MemberLoginRequest;
//import kr.eddi.ztz_process.service.member.request.MemberModifyRequest;
import kr.eddi.ztz_process.service.member.request.MemberModifyRequest;
import kr.eddi.ztz_process.service.member.request.MemberRegisterRequest;
import kr.eddi.ztz_process.service.security.RedisService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberRepository memberRepository;
    @Autowired
    private PaymentRepository paymentRepository;
    @Autowired
    private ReservationRepository reservationRepository;
    @Autowired
    private QuestionRepository questionRepository;
    @Autowired
    private QuestionCommentRepository questionCommentRepository;
    @Autowired
    private FavoriteRepository favoriteRepository;
    @Autowired
    private AuthenticationRepository authenticationRepository;

    @Autowired
    private BasicAuthenticationRepository basicAuthenticationRepository;

    @Autowired
    private ManagerCodeRepository managerCodeRepository;

    @Autowired
    private OrderInfoRepository orderInfoRepository;

    @Autowired
    private RedisService redisService;

    @Autowired
    private ReviewRepository reviewRepository;
    @Autowired
    private MemberProfileRepository memberProfileRepository;
    @Autowired
    private ItemRepository itemRepository;
    @Autowired
    private AuthorityRepository authorityRepository;
    @Autowired
    private CartRepository cartRepository;
    @Override
    public Boolean emailValidation(String email) {
        Optional<Member> maybeMember = memberRepository.findByEmail(email);
        if (maybeMember.isPresent()) {
            return false;
        }
        return true;
    }

    @Override
    public Boolean managerCodeValidation(String managerCode) {
        Optional<ManagerCode> maybeManager = managerCodeRepository.findByCode(managerCode);
        if (maybeManager.isPresent()) {
            return true;
        }
        return false;
    }

    @Override
    public Boolean signUp(MemberRegisterRequest request) {
        log.info("매니저코드: " + request.getManagerCode());
        if (request.getManagerCode() == null || request.getManagerCode().isEmpty()) {
            log.info("일반회원 가입");
            final Member member = request.toMember();
            memberRepository.save(member);

            final BasicAuthentication auth = new BasicAuthentication(member,
                    Authentication.BASIC_AUTH, request.getPassword());

            authenticationRepository.save(auth);

        } else {
            log.info("관리자회원 가입");
            final Member member = request.toManager();
            memberRepository.save(member);

            final BasicAuthentication auth = new BasicAuthentication(member,
                    Authentication.BASIC_AUTH, request.getPassword());

            authenticationRepository.save(auth);
        }

        return true;
    }

    @Override
    public String signIn(MemberLoginRequest request) {
        String email = request.getEmail();
        Optional<Member> maybeMember = memberRepository.findByEmail(email);

        if (maybeMember.isPresent()) {
            Member member = maybeMember.get();

            log.info("member email: " + member.getEmail());
            log.info("request email: " + request.getEmail());
            log.info("request password: " + request.getPassword());

            if (!member.isRightPassword(request.getPassword())) {
                // 패스워드가 잘못 된 경우
                throw new RuntimeException("아이디 또는 패스워드가 잘못되었습니다");
            }

            UUID userToken = UUID.randomUUID();

            redisService.deleteByKey(userToken.toString());
            redisService.setKeyAndValue(userToken.toString(), member.getId());

            log.info("유저토큰: " + userToken.toString());
            log.info("레디스 유저토큰으로 멤버아이디 구하기: " + redisService.getValueByKey(userToken.toString()));
            log.info("유저토큰:" + userToken.toString() + " 멤버아이디:" + member.getId());
            return userToken.toString();
        }

        // 이메일이 가입되어 있지 않은 경우
        throw new RuntimeException("아이디 또는 패스워드가 잘못되었습니다");
    }

    @Override
    public void withdrawal(String token) {
        Long id = redisService.getValueByKey(token);
        Member member = memberRepository.findByMemberId(id);

        //리뷰 삭제
        List<Review> reviewList = reviewRepository.findByMemberId(member.getId());
        for (int i = 0; i <reviewList.size(); i++) {
            reviewRepository.delete(reviewList.get(i));
        }
        //주문정보 삭제
        List<OrderInfo> orderInfoList = orderInfoRepository.findByMemberId(member.getId());
        for (int i = 0; i <orderInfoList.size(); i++) {
            orderInfoRepository.delete(orderInfoList.get(i));
        }
        //결제정보 삭제
        List<Payment> paymentList = paymentRepository.findAllByMemberId(member.getId());
        for (int i = 0; i <paymentList.size(); i++) {
            paymentRepository.delete(paymentList.get(i));
        }
        //찜삭제
        List<Favorite> favoriteList = favoriteRepository.findByFavoriteAllByMemberId(member.getId());
        for (int i = 0; i <favoriteList.size(); i++) {
            favoriteRepository.delete(favoriteList.get(i));
        }
        //예약삭제
        List<Reservation> reservationList = reservationRepository.findByMemberId(member.getId());
        for (int i = 0; i <reservationList.size(); i++) {
            reservationRepository.delete(reservationList.get(i));
        }
        //문의 댓글 삭제
        //문의 삭제
        List<QuestionBoard> questionBoardList = questionRepository.findByMemberId(member.getId());
        for (int i = 0; i <questionBoardList.size(); i++) {
            Optional<QuestionComment> maybeQuestionComment = questionCommentRepository.findOptionalByQuestionNo(questionBoardList.get(i).getQuestionNo());
            if(maybeQuestionComment.isPresent()){
                questionCommentRepository.delete(maybeQuestionComment.get());
            }
            questionRepository.delete(questionBoardList.get(i));
        }
        //장바구니 삭제
        Optional<Cart> maybeCart = cartRepository.findByMemberId(member.getId());
        if(maybeCart.isPresent()){
            List<Item> itemList = itemRepository.findCartListByMemberId(member.getId());
            for (int i = 0; i <itemList.size(); i++) {
                itemRepository.delete(itemList.get(i));
            }
            cartRepository.delete(maybeCart.get());
        }

        memberRepository.delete(member);
        authorityRepository.delete(member.getAuthority());
    }

    @Override
    public Member returnMemberInfo(String token) {
        Long id = redisService.getValueByKey(token);
        Member member = memberRepository.findByMemberId(id);

        return member;
    }

    @Override
    public MemberProfile returnMemberProfile(String token) {
        Long id = redisService.getValueByKey(token);
        Member member = memberRepository.findByMemberId(id);

        MemberProfile memberProfile = memberProfileRepository.findProfileByMemberId(member.getId());
        return memberProfile;
    }

    @Override
    public Boolean ModifyMemberAddress(MemberAddressRequest memberAddressRequest) {
        try {
            String maybeToken = "";
            if(memberAddressRequest.getToken().length() >= 37){
                maybeToken = memberAddressRequest.getToken().substring(1,37);
            }else {
                maybeToken = memberAddressRequest.getToken();
            }
            Long id = redisService.getValueByKey(maybeToken);
            Member member = memberRepository.findByMemberId(id);
            MemberProfile memberProfile = memberProfileRepository.findProfileByMemberId(member.getId());

            Address address = Address.of(
                    memberAddressRequest.getCity(),
                    memberAddressRequest.getStreet(),
                    memberAddressRequest.getAddressDetail(),
                    memberAddressRequest.getZipcode());
            memberProfile.modifyAddress(address);

            memberProfileRepository.save(memberProfile);
            return true;

        } catch (Exception e) {
            System.out.println(e);

            return false;
        }
    }

    @Override
    public String ModifyMemberProfile(MemberModifyRequest memberModifyRequest) {
        String msg = "";

        try {
            Member member = memberRepository.findByMemberId(memberModifyRequest.getId());
            MemberProfile memberProfile = memberProfileRepository.findProfileByMemberId(member.getId());

            log.info("관리자 코드: " + memberModifyRequest.getManager_code());
            Optional<Authentication> authentication = authenticationRepository.findByMemberId(memberModifyRequest.getId());
            log.info("new password check" + memberModifyRequest.getNew_password());
                log.info("회원정보 변경");
                if ((memberModifyRequest.getNew_password() == null || memberModifyRequest.getNew_password().isEmpty()) && (memberModifyRequest.getPhoneNumber() != null || !memberModifyRequest.getPhoneNumber().isEmpty())) { // 핸드폰번호만 수정!
                    memberProfile.modifyPhoneNumber(memberModifyRequest.getPhoneNumber());
                    memberProfileRepository.save(memberProfile);
                } else if ((memberModifyRequest.getNew_password() != null || !memberModifyRequest.getNew_password().isEmpty()) && (memberModifyRequest.getPhoneNumber() == null || memberModifyRequest.getPhoneNumber().isEmpty())) { // 비밀번호만 수정!
                    Optional<BasicAuthentication> maybeBasicAuthentication = basicAuthenticationRepository.findByMemberID(memberModifyRequest.getId());
                    BasicAuthentication basicAuthentication = maybeBasicAuthentication.get();
                    basicAuthentication.setPassword(memberModifyRequest.getNew_password());
                    basicAuthenticationRepository.save(basicAuthentication);
                } else {
                    memberProfile.modifyPhoneNumber(memberModifyRequest.getPhoneNumber());
                    memberProfileRepository.save(memberProfile);
                    Optional<BasicAuthentication> maybeBasicAuthentication = basicAuthenticationRepository.findByMemberID(memberModifyRequest.getId());
                    BasicAuthentication basicAuthentication = maybeBasicAuthentication.get();
                    basicAuthentication.setPassword(memberModifyRequest.getNew_password());
                    basicAuthenticationRepository.save(basicAuthentication);
                }

                return msg = "회원정보 변경이 성공되었습니다.";

        } catch (Exception e) {
            System.out.println(e);

            return msg = "회원정보 변경이 실패되었습니다. 다시 시도해주세요.";
        }
    }

    @Override
    public String returnManagerProfile(String token) {
        Long id = redisService.getValueByKey(token); // 회원번호를 반환해서 그 값을 id로 담는다!
        Member member = memberRepository.findByMemberId(id); // 멤버정보를 MemberId값으로 찾으면서 Member 클래스를 데이터 타입으로 가져온다.

        MemberProfile memberProfile = memberProfileRepository.findProfileByMemberId(member.getId()); // 멤버 프로필 정보 조회
        System.out.println("관리자 번호는 : " + memberProfile.getPhoneNumber());
        return memberProfile.getPhoneNumber();
    }
}
