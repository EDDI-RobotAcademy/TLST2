package kr.eddi.ztz_process.service.order;

import kr.eddi.ztz_process.controller.order.ResponseOrderInfo;
import kr.eddi.ztz_process.controller.order.request.CancelRequest;
import kr.eddi.ztz_process.controller.order.request.ModifyRequest;
import kr.eddi.ztz_process.controller.order.request.OrderRequest;

import java.util.List;

public interface OrderService {

    public List<ResponseOrderInfo> orderInfoList(List<OrderRequest> orderRequest);

    public Boolean registerOrderInfo(List<OrderRequest> orderRequest);

    public Boolean CancelAllOrder(CancelRequest cancelRequest);

    public Boolean ModifyOrder(List<ModifyRequest> modifyRequest);

}
