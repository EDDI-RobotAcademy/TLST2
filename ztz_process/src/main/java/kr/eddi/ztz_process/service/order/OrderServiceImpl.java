package kr.eddi.ztz_process.service.order;

import kr.eddi.ztz_process.controller.order.request.CancelRequest;
import kr.eddi.ztz_process.controller.order.request.ModifyRequest;
import kr.eddi.ztz_process.entity.order.OrderInfo;
import kr.eddi.ztz_process.controller.order.ResponseOrderInfo;
import kr.eddi.ztz_process.repository.order.OrderInfoRepository;
import kr.eddi.ztz_process.controller.order.request.OrderRequest;
import kr.eddi.ztz_process.utility.order.setRandomOrderNo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    @Override
    public List<ResponseOrderInfo> orderInfoList(List<OrderRequest> orderRequest) {
        orderRequest.get(0).getProductNo(); // 이걸로 각 상품의 정보 조회.
        orderRequest.get(0).getMemberNo(); // 이걸로 해당 상품을 주문한 고객의 주소정보 조회
        List<ResponseOrderInfo> responseOrderInfoList = new ArrayList<>();

        for (int i=0; i<= orderRequest.size();i++){
            responseOrderInfoList.add(
                    ResponseOrderInfo.builder()
                            .productName("testProduct") // 조회한 데이터를 여기서 넣어서 저장후
                            .productCnt(orderRequest.get(0).getOrderCnt())
                            .productPrice(10000)
                            .productThumbnailRoute("test")
                            /* .memberAddress()*/
                            .build()
            );
        }
        return responseOrderInfoList; // 화면에 표시 할 수있는 데이터들을 응답.
    }

    @Override
    public Boolean registerOrderInfo(List<OrderRequest> orderRequest) {
        //orderRequest.get(0).getProductNo();
        //orderRequest.get(0).getMemberNo();//여기서도 마찬가지로 해당 데이터 들로 상품들 조회.

        Integer setOrderNum;
        while (true){
            setOrderNum = setRandomOrderNo.makeIntCustomRandom(MINORDERNUM , MAXORDERNUM);
            Optional maybeOrderNo = orderRepository.findById(Long.valueOf(setOrderNum));
            if (maybeOrderNo.isPresent()){
                continue;
            }else {
                break;
            }
        }

        try {
            for (int i=0; i<= orderRequest.size();i++){
                OrderInfo orderInfo = OrderInfo
                        .builder()
                        .orderID(setOrderNum)
                        .orderCnt(orderRequest.get(i).getOrderCnt())
                        .orderedProductName("테스트상품")
                        .productPrice(10000)
                        .productThumbnailRoute("썸네일주소")
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
        List<Optional<OrderInfo>> mayBeOrder = orderRepository.findByOrderID(cancelRequest.getOrderID());

        try{
            if(mayBeOrder.get(0).isPresent()){
                for(int i = 0; i <= mayBeOrder.size(); i++){
                    OrderInfo orderInfo = mayBeOrder.get(i).get();
                    orderRepository.deleteById(orderInfo.getOrderNo());
                }
                return true;
            }else {
                System.out.println("해당하는 주문 번호가 없습니다");
                return false;
            }
        }catch (Exception e){
            System.out.println("오류 발생 " + e);
            return false;
        }
    }

    @Override
    public Boolean ModifyOrder(List<ModifyRequest> modifyRequest) {
        List<OrderInfo> orderInfoList = new ArrayList<>();

        try{
            for (int i=0; i < modifyRequest.size(); i++){
                Integer RequestOrderID = modifyRequest.get(i).getOrderID();
                String RequestProductName = modifyRequest.get(i).getProductName();

                Optional<OrderInfo> maybeOrder = orderRepository.findProductByIdAndName(RequestOrderID,RequestProductName);

                if(maybeOrder.isEmpty()){
                    System.out.println("해당 주문번호와 이름으로 저장된 데이터가 없습니다.");
                    return false;
                }

                orderInfoList.add(maybeOrder.get());
            }

            for (int i = 0; i < modifyRequest.size(); i++) {
                if(modifyRequest.get(i).getModifyCnt() == 0 ){
                    orderRepository.deleteById(orderInfoList.get(i).getOrderNo());
                    System.out.println("해당 상품 취소를 완료 했습니다.");
                }else {
                    OrderInfo orderInfo = orderInfoList.get(i);
                    orderInfo.ModifyOrderCnt(modifyRequest.get(i).getModifyCnt());
                    orderRepository.save(orderInfo);
                    System.out.println("주문 갯수 수정을 완료 했습니다.");
                }
            }
            return true;
        }catch (Exception e){
            System.out.println(e);
            return false;
        }
    }


}
