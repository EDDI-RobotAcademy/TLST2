package kr.eddi.ztz_process.service.order;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import kr.eddi.ztz_process.controller.order.form.OrderInfoRegisterForm;
import kr.eddi.ztz_process.controller.order.request.RefundRequest;
import kr.eddi.ztz_process.controller.order.request.ChangeOrderStateRequest;
import kr.eddi.ztz_process.entity.member.Address;
import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.entity.order.Payment;
import kr.eddi.ztz_process.entity.order.PaymentState;
import kr.eddi.ztz_process.entity.products.Product;
import kr.eddi.ztz_process.repository.member.MemberRepository;
import kr.eddi.ztz_process.repository.order.PaymentRepository;
import kr.eddi.ztz_process.repository.products.ProductsRepository;
import kr.eddi.ztz_process.entity.order.OrderInfo;
import kr.eddi.ztz_process.repository.order.OrderInfoRepository;
import kr.eddi.ztz_process.service.order.request.PaymentRegisterRequest;
import kr.eddi.ztz_process.service.security.RedisService;
import kr.eddi.ztz_process.utility.order.setRandomOrderNo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

@Service
@Slf4j
public class OrderServiceImpl implements OrderService {
    private final Integer MINORDERNUM = 1;
    private final Integer MAXORDERNUM = 99999;

    @Autowired
    OrderInfoRepository orderRepository;

    @Autowired
    PaymentRepository paymentRepository;

    @Autowired
    RedisService redisService;
    @Autowired
    ProductsRepository productsRepository;

    @Autowired
    MemberRepository memberRepository;

    @Override
    public Boolean registerOrderInfo(PaymentRegisterRequest paymentRegisterRequest) {
        try {
            //?????? ?????? ??????
            Payment payment = registerPayment(paymentRegisterRequest);

            OrderInfoRegisterForm OrderListInfo = paymentRegisterRequest.getSendInfo();

            // ?????? ?????? ??????
            String setOrderNum = MakeOrderedNo(OrderListInfo.getMemberID().get(0));

            for (int i = 0; i < OrderListInfo.getProductID().size(); i++) {
                Optional<Product> maybeProduct = productsRepository.findById(OrderListInfo.getProductID().get(i));
                Optional<Member> maybeMember = memberRepository.findById(OrderListInfo.getMemberID().get(i));

                OrderInfo orderInfo = OrderInfo
                        .builder()
                        .orderNo(setOrderNum)
                        .orderCnt(OrderListInfo.getOrderCnt().get(i))
                        .orderState(PaymentState.PAYMENT_COMPLETE)
                        .orderPrice(OrderListInfo.getOrderPrice().get(i))
                        .product(maybeProduct.get())
                        .member(maybeMember.get())
                        .payment(payment)
                        .build();
                orderRepository.save(orderInfo);
            }
            return true;
        } catch (Exception e) {
            System.out.println("?????? ??????" + e);
            return false;
        }
    }

    @Override
    public List<OrderInfo> readAllOrders(Long PaymentId) {

        List<OrderInfo> orderInfo = orderRepository.findByPaymentId(PaymentId);

        return orderInfo;
    }

    @Override
    public List<Payment> readAllPayment(String token) {
        Long id = redisService.getValueByKey(token);
        Member member = memberRepository.findByMemberId(id);
        System.out.println("?????? ??????" + member.getId());


        List<Payment> payments = paymentRepository.findAllByMemberId(member.getId());
        return payments;
    }

    @Override
    public List<Payment> readRangePaymentList(String token , String readData){
        Long id = redisService.getValueByKey(token);
        Member member = memberRepository.findByMemberId(id);
        System.out.println("?????? ??????" + member.getId());

        LocalDateTime nowData = LocalDateTime.now();
        LocalDateTime endData;

        switch (readData){
            case "3??????":
                endData = LocalDateTime.now().minusDays(1L);
                break;
            case "6??????":
                endData = LocalDateTime.now().minusMonths(6L);
                break;
            case "1???":
                endData = LocalDateTime.now().minusYears(1L);
                break;
            default:
                System.out.println("???????????? ???????????? ????????????");
                return null;
        }
        System.out.println("staetDate : " + nowData.format(DateTimeFormatter.ofPattern("yyyy.MM.dd (HH??? mm???)")));
        System.out.println("endDate : " + endData.format(DateTimeFormatter.ofPattern("yyyy.MM.dd (HH??? mm???)")));

        List<Payment> payments = paymentRepository.findByEndData(endData ,member.getId());
        return payments;
    }

    @Override
    public List<Payment> readManagerAllPayment() {
        List<Payment> payments = paymentRepository.findAllPaymentList();
        return payments;
    }

    @Override
    public Boolean refundAllOrder(RefundRequest refundRequest) throws IOException {
        String test_api_key = "2701111347244503";
        String test_api_secret = "J7xV8xenAUsYtgiuUjwAJNJ7o2Ax4VnSsaABT0G04YDwedek5x0Rzp0e1elG2od4sZTyUzVygtxUUwnp";
        IamportClient client = new IamportClient(test_api_key, test_api_secret);

        Optional<Payment> maybePayment = paymentRepository.findById(refundRequest.getRefundPaymentId());
        Payment payment = maybePayment.get();
        List<OrderInfo> orderInfos = orderRepository.findByPaymentId(payment.getPaymentId());
        String uid = payment.getImp_uid();
        System.out.println(uid);
        CancelData cancelData = new CancelData(uid, true);

        try {
            client.cancelPaymentByImpUid(cancelData);

            payment.setPaymentState(PaymentState.PAYMENT_REFUND);
            for (int i = 0; i < orderInfos.size(); i++) {
                orderInfos.get(i).setOrderState(PaymentState.PAYMENT_REFUND);
                orderInfos.get(i).setRefundReason(refundRequest.getRefundReason());
                orderRepository.save(orderInfos.get(i));
            }
            paymentRepository.save(payment);
        } catch (IamportResponseException e) {
            System.out.println("?????? ?????? ??????");
            System.out.println("?????? :" + e);
        }
        return true;
    }

    public Payment registerPayment(PaymentRegisterRequest paymentRegisterRequest) {

        OrderInfoRegisterForm OrderListInfo = paymentRegisterRequest.getSendInfo();
        Optional<Product> maybeProduct = productsRepository.findById(OrderListInfo.getProductID().get(0));
        Product product = maybeProduct.get();
        Integer TotalOrderedCnt = 0;
        Optional<Member> maybeMember = memberRepository.findById(OrderListInfo.getMemberID().get(0));
        for (int i = 0; i < paymentRegisterRequest.getSendInfo().getOrderCnt().size(); i++) {
            TotalOrderedCnt += paymentRegisterRequest.getSendInfo().getOrderCnt().get(i);
        }
        Address address = Address.of(
                paymentRegisterRequest.getCity(),
                paymentRegisterRequest.getStreet(),
                paymentRegisterRequest.getAddressDetail(),
                paymentRegisterRequest.getZipcode()
        );

        Payment payment = Payment.
                builder()
                .paymentTitle(
                        OrderListInfo.getProductID().size() == 1 ?
                                product.getName() :
                                product.getName() + " ??? " + (OrderListInfo.getProductID().size() - 1) + "???")
                .merchant_uid(paymentRegisterRequest.getMerchant_uid())
                .totalPaymentPrice(paymentRegisterRequest.getPaymentPrice())
                .imp_uid(paymentRegisterRequest.getImp_uid())
                .OrderedCnt(TotalOrderedCnt)
                .PaymentState(PaymentState.PAYMENT_COMPLETE)
                .address(address)
                .DeliveryRequest(paymentRegisterRequest.getSendRequest())
                .member(maybeMember.get())
                .build();


        paymentRepository.save(payment);

        return payment;
    }

    public String MakeOrderedNo(Long memberID) {
        LocalDate createdDateAt;
        createdDateAt = LocalDate.now();

        String setOrderNum;

        while (true) {
            setOrderNum = String.valueOf(setRandomOrderNo.makeIntCustomRandom(MINORDERNUM, MAXORDERNUM));
            Optional<OrderInfo> maybeOrderNo = orderRepository.findByOrderNo(setOrderNum);
            if (maybeOrderNo.isPresent()) {
                System.out.println("?????? ????????? ?????????" + maybeOrderNo.get());
            } else {
                setOrderNum += "-" + createdDateAt + "-";
                setOrderNum += memberID;
                break;
            }
        }


        return setOrderNum;
    }

    public List<OrderInfo> changeOrderState(ChangeOrderStateRequest changeOrderStateRequest) {

        //????????????, ????????????, ????????????, ???????????? 4??? reqType
        String reqType = changeOrderStateRequest.getReqType();
        PaymentState setState = null;
        Boolean allSameOrderStateCheck = false;
        int sameOrderStateNum = 0;

        if (reqType.equals("????????????")) {
            setState = PaymentState.DELIVERY_ONGOING;
        } else if (reqType.equals("????????????")) {
            setState = PaymentState.DELIVERY_COMPLETE;
        } else if (reqType.equals("????????????")) {
            setState = PaymentState.PAYMENT_CONFIRM;
        } else if (reqType.equals("????????????")) {
            setState = PaymentState.REFUND_REQUEST;
        }

        // orderinfo??? ?????? ?????? ???????????? ?????? ???????????????
        Optional<OrderInfo> maybeOrderInfo = orderRepository.findById(changeOrderStateRequest.getOrderId());
        OrderInfo startOrderInfo = maybeOrderInfo.get();
        startOrderInfo.setOrderState(setState);

        orderRepository.save(startOrderInfo);

        //????????? ??????????????? ???????????? ???! ?????? if paymentid ????????? ?????? ??? -> "?????????" ?????? ???????????? ????????? ?????????
        List<OrderInfo> findOrderInfoPaymentList = orderRepository.findByPaymentId(changeOrderStateRequest.getPaymentId());

        for (int i = 0; i < findOrderInfoPaymentList.size(); i++) {
            if (findOrderInfoPaymentList.get(i).getOrderState().equals(setState)) {
                sameOrderStateNum = sameOrderStateNum + 1;
            }
        }
        if (findOrderInfoPaymentList.size() == sameOrderStateNum) {
            allSameOrderStateCheck = true;
        }

        //payment - ????????? ????????? ?????? paymentId??? ???????????? orderInfo?????? ??? ???????????? ??? ?????? payment ?????? ?????? ?????? -> ?????????
        //payment ?????? ??? 1????????? ???????????? ?????? ???????????? ????????? ????????? ??????
        Optional<Payment> maybePayment = paymentRepository.findById(changeOrderStateRequest.getPaymentId());
        Payment payment = maybePayment.get();

        if (allSameOrderStateCheck) {
            payment.setPaymentState(setState);
        } else {
            payment.setPaymentState(PaymentState.PART_DELIVERY_ONGOING);
        }
        paymentRepository.save(payment);

        return findOrderInfoPaymentList;
    }

    public Integer salesAmount() {
        List<OrderInfo> salesOrderInfo = orderRepository.findSalesList();
        log.info("??????????????? ?????????: ");
        Integer totalSalesAmount = 0;

        for (int i = 0; i < salesOrderInfo.size(); i++) {
            totalSalesAmount = totalSalesAmount + salesOrderInfo.get(i).getOrderPrice();
        }

        return totalSalesAmount;
    }
}
