package kr.eddi.ztz_process.service.order;

import kr.eddi.ztz_process.entity.order.ResponseOrderInfo;
import kr.eddi.ztz_process.repository.order.OrderRequest;
import org.springframework.stereotype.Service;

import java.util.List;

public interface OrderService {

    public List<ResponseOrderInfo> orderInfoList(List<OrderRequest> orderRequest);

    public Boolean registerOrderInfo(List<OrderRequest> orderRequest);
}
