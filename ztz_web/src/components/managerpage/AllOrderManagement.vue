<template>
  <div class="mt-5 ml-5">
    <div class="head-area">
      <p class=" head-text">주문관리</p>
      <div align="right" class="mr-3 mb-3">총 {{ this.$store.state.paymentList.length }} 건</div>
    </div>
    <v-card outlined class="orderedInfo">
      <v-simple-table border="1">
        <thead>
        <tr>
          <th class="text-center">주문 번호</th>
          <th>주문 갯수</th>
          <th>총 가격</th>
          <th>주문 상태</th>
          <th >주문 날짜</th>
          <th>주문 정보</th>
        </tr>
        </thead>
        <tbody>
        <tr v-if="!paymentList || (Array.isArray(paymentList) && paymentList.length === 0)">
          <td colspan="6" align="center">
            주문 내역이 존재하지 않습니다.
          </td>
        </tr>
        <tr v-else v-for="(paymentItem, index) in paymentList" :key="index">
          <td class="pa-0" align="center">{{ paymentItem.merchant_uid }}</td>
          <td class="pl-9">{{ paymentItem.orderedCnt }}</td>
          <td>{{ paymentItem.totalPaymentPrice | numberFormat }}원</td>
          <td>{{
              paymentItem.paymentState == "PAYMENT_COMPLETE" ? "결제완료" :
                  paymentItem.paymentState == "PAYMENT_REFUND" ? "환불완료" :
                      paymentItem.paymentState == "DELIVERY_START" ? "배송시작" :
                          paymentItem.paymentState == "PART_DELIVERY_ONGOING" ? "부분배송중" :
                              paymentItem.paymentState == "DELIVERY_ONGOING" ? "배송중" :
                                  paymentItem.paymentState == "DELIVERY_COMPLETE" ? "배송완료" :
                                      paymentItem.paymentState == "PAYMENT_CONFIRM" ? "구매확정" :
                                          paymentItem.paymentState == "REFUND_REQUEST" ? "반품신청" :
                                              paymentItem.paymentState == "WRITE_REVIEW" ? "리뷰작성 완료" :
                                                  paymentItem.paymentState == "PART_WRITE_REVIEW" ? "일부리뷰 작성 완료" :
                                                      paymentItem.paymentState == "ABLE_WRITE_REVIEW" ? "리뷰작성가능" :
                                                          "지정된 상태값이 없습니다"
            }}</td>
          <td>{{ paymentItem.regData }}</td>
          <td>
            <v-btn class="orderedBtn" @click="showOrderDetails(paymentItem.paymentId, index)">
              상세정보
            </v-btn>
          </td>
        </tr>
        </tbody>
      </v-simple-table>
    </v-card>

    <template>
      <v-dialog v-model="showOrderDetail" width="1000">
        <all-order-detail-form :paymentId="this.paymentId"
                               :paymentListIndex="this.paymentListIndex"
                               @startDelivery="startDelivery"
                               @finDelivery="finDelivery"
        />
      </v-dialog>
    </template>
  </div>
</template>


<script>
import {mapActions, mapState} from "vuex";
import AllOrderDetailForm from "@/components/managerpage/AllOrderDetailForm";

export default {
  name: "AllOrderManagement",
  components: {AllOrderDetailForm},
  data() {
    return {
      showOrderDetail: false,

      paymentListIndex: 0,
      paymentId: 0,
    }
  },
  computed: {
    ...mapState([
      'isAuthenticated',
      'paymentList',
      'orderedList'
    ])
  },
  mounted() {
    this.reqPaymentListFromSpring()
  },
  methods: {
    ...mapActions([
      'reqPaymentListFromSpring',
      'reqOrderedListFromSpring',
      'reqChangeOrderStateToSpring'
    ]),
    async showOrderDetails(paymentId, index) {
      this.paymentId = paymentId
      this.paymentListIndex = index
      this.showOrderDetail = true
      await this.reqOrderedListFromSpring(paymentId)
    },
    startDelivery(payload) {
      const reqType ="배송시작"
      const orderId = payload.startDeliveryOrderId
      const paymentId = payload.startDeliveryPaymentId
      console.log("배송시작 주문상태변수: "+reqType + orderId+ paymentId)
      this.reqChangeOrderStateToSpring({reqType, orderId, paymentId})
    },
    finDelivery(payload){
      const reqType ="배송완료"
      const orderId = payload.finDeliveryOrderId
      const paymentId = payload.finDeliveryPaymentId
      console.log("배송완료 주문상태변수: "+reqType + orderId+ paymentId)
      this.reqChangeOrderStateToSpring({reqType, orderId, paymentId})
    }
  },
}
</script>

<style scoped>
.orderedInfo {
  overflow-y: scroll;
  max-height: 180px;
}

.orderedBtn {
  font-size: 12px;
  max-height: 20px;
  max-width: 6px;
}
</style>