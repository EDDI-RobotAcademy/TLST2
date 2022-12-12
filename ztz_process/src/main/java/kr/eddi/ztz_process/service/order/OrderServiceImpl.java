package kr.eddi.ztz_process.service.order;

import kr.eddi.ztz_process.controller.order.form.OrderInfoRegisterForm;
import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.entity.order.Payment;
import kr.eddi.ztz_process.entity.products.Product;
import kr.eddi.ztz_process.repository.member.MemberRepository;
import kr.eddi.ztz_process.repository.order.PaymentRepository;
import kr.eddi.ztz_process.repository.products.ProductsRepository;
import kr.eddi.ztz_process.service.order.request.CancelRequest;
import kr.eddi.ztz_process.service.order.request.ModifyRequest;
import kr.eddi.ztz_process.entity.order.OrderInfo;
import kr.eddi.ztz_process.repository.order.OrderInfoRepository;
import kr.eddi.ztz_process.service.order.request.PaymentRegisterRequest;
import kr.eddi.ztz_process.utility.order.setRandomOrderNo;
import lombok.Value;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Slf4j
public class OrderServiceImpl implements OrderService{
    private final Integer MINORDERNUM = 1;
    private final Integer MAXORDERNUM = 99999;

    @Autowired
    OrderInfoRepository orderRepository;

    @Autowired
    PaymentRepository paymentRepository;

    @Autowired
    ProductsRepository productsRepository;

    @Autowired
    MemberRepository memberRepository;

    @Override
    public Boolean registerOrderInfo(PaymentRegisterRequest paymentRegisterRequest) {
        try {
             //결제 정보 저장
            Payment payment = registerPayment(paymentRegisterRequest);

            OrderInfoRegisterForm OrderListInfo = paymentRegisterRequest.getSendInfo();

            // 주문 번호 생성
            String setOrderNum = MakeOrderedNo(OrderListInfo.getMemberID().get(0));

            for (int i = 0; i < OrderListInfo.getProductID().size(); i++) {
                Optional<Product> maybeProduct = productsRepository.findById(OrderListInfo.getProductID().get(i));
                Optional<Member> maybeMember = memberRepository.findById(OrderListInfo.getMemberID().get(i));

                OrderInfo orderInfo = OrderInfo
                        .builder()
                        .orderNo(setOrderNum)
                        .orderCnt(OrderListInfo.getOrderCnt().get(i))
                        .product(maybeProduct.get())
                        .member(maybeMember.get())
                        .payment(payment)
                        .build();
                orderRepository.save(orderInfo);
            }
            return true;
        }catch (Exception e){
            System.out.println("오류 발생" + e);
            return false;
        }
    }

    @Override
    public Boolean CancelAllOrder(CancelRequest cancelRequest) {

        return false;
//        List<Optional<OrderInfo>> mayBeOrder = orderRepository.findByOrderID(cancelRequest.getOrderID());
//
//        try{
//            if(mayBeOrder.get(0).isPresent()){
//                for(int i = 0; i <= mayBeOrder.size(); i++){
//                    OrderInfo orderInfo = mayBeOrder.get(i).get();
//                    orderRepository.deleteById(orderInfo.getOrderID());
//                }
//                return true;
//            }else {
//                System.out.println("해당하는 주문 번호가 없습니다");
//                return false;
//            }
//        }catch (Exception e){
//            System.out.println("오류 발생 " + e);
//            return false;
//        }
    }

    @Override
    public Boolean ModifyOrder(List<ModifyRequest> modifyRequest) {

        return false;
//        List<OrderInfo> orderInfoList = new ArrayList<>();
//
//        try{
//            for (int i=0; i < modifyRequest.size(); i++){
//                Integer RequestOrderID = modifyRequest.get(i).getOrderID();
//                String RequestProductName = modifyRequest.get(i).getProductName();
//
//                Optional<OrderInfo> maybeOrder = orderRepository.findProductByIdAndName(RequestOrderID,RequestProductName);
//
//                if(maybeOrder.isEmpty()){
//                    System.out.println("해당 주문번호와 이름으로 저장된 데이터가 없습니다.");
//                    return false;
//                }
//
//                orderInfoList.add(maybeOrder.get());
//            }
//
//            for (int i = 0; i < modifyRequest.size(); i++) {
//                if(modifyRequest.get(i).getModifyCnt() == 0 ){
//                    orderRepository.deleteById(orderInfoList.get(i).getOrderID());
//                    System.out.println("해당 상품 취소를 완료 했습니다.");
//                }else {
//                    OrderInfo orderInfo = orderInfoList.get(i);
//                    orderInfo.ModifyOrderCnt(modifyRequest.get(i).getModifyCnt());
//                    orderRepository.save(orderInfo);
//                    System.out.println("주문 갯수 수정을 완료 했습니다.");
//                }
//            }
//            return true;
//        }catch (Exception e){
//            System.out.println(e);
//            return false;
//        }
    }


    public Payment registerPayment(PaymentRegisterRequest paymentRegisterRequest){
        Payment payment = Payment.
                builder()
                .merchant_uid(paymentRegisterRequest.getMerchant_uid())
                .totalPaymentPrice(paymentRegisterRequest.getPaymentPrice())
                .build();

        paymentRepository.save(payment);

        return payment;
    }
    public String MakeOrderedNo(Long memberID){
        LocalDate createdDateAt;
        createdDateAt = LocalDate.now();

        String setOrderNum;

        while (true){
            setOrderNum = String.valueOf(setRandomOrderNo.makeIntCustomRandom(MINORDERNUM , MAXORDERNUM));
           Optional<OrderInfo> maybeOrderNo = orderRepository.findByOrderNo(setOrderNum);
            if (maybeOrderNo.isPresent()){
                System.out.println("주문 아이디 재생성" + maybeOrderNo.get());
            }else {
                setOrderNum += "-" + createdDateAt + "-";
                setOrderNum += memberID;
                break;
            }
        }



        return setOrderNum;
    }
}
