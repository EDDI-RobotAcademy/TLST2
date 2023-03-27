<template>
  <div class="mt-10 ml-5">
    <div class="head-area">
      <button-white small width="64px" style="padding: 0 16px 0 10px; font-size: 13px" btn-name="3개월"
        @click="rangepayment('3개월')" />
      <button-white small width="64px" style="padding: 0 16px 0 10px; font-size: 13px" btn-name="6개월"
        @click="rangepayment('6개월')" />
      <button-white small width="64px" style="padding: 0 16px 0 10px; font-size: 13px" btn-name="1년"
        @click="rangepayment('1년')" />
      <div align="right" class="mr-3 mb-3">총 {{ this.$store.state.paymentList.length }} 건</div>
    </div>
    <v-card outlined class="orderedInfo">
      <v-simple-table border="1">
        <thead>
          <tr>
            <th>주문 번호</th>
            <th>주문 갯수</th>
            <th>총 가격</th>
            <th>주문 상태</th>
            <th>주문 날짜</th>
            <th>주문 정보</th>
          </tr>
        </thead>
        <tbody>
        <tr v-if="!paymentList || (Array.isArray(paymentList) && paymentList.length === 0)">
          <td colspan="6" align="center">
            주문 내역이 존재하지 않습니다.
          </td>
        </tr>
        <tr v-for="(paymentItem,index) in paymentList" :key="index">
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
        <order-detail-form :paymentId="this.paymentId"
                           :paymentListIndex="this.paymentListIndex"
                           @confirmPurchase="confirmPurchase"
                           @returnProduct="returnProduct"
        />
      </v-dialog>
    </template>
  </div>
</template>


<script>
import { mapActions, mapState } from "vuex";
import OrderDetailForm from "@/components/mypage/OrderDetailForm";

export default {
  name: "OrderManagement",
  components: { OrderDetailForm },
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
  async mounted() {
    if (this.$store.state.isAuthenticated === true) {
      let token = window.localStorage.getItem('userInfo')
      await this.reqPaymentListFromSpring(token)
    } else {
      alert("로그인 상태가 아닙니다.")
    }
  },
  methods: {
    ...mapActions([
      'reqPaymentListFromSpring',
      'reqOrderedListFromSpring',
      'reqChangeOrderStateToSpring',
      'reqReadRangePaymentList'
    ]),
    async showOrderDetails(paymentId, index) {
      this.paymentId = paymentId
      this.paymentListIndex = index
      this.showOrderDetail = true
      await this.reqOrderedListFromSpring(paymentId)
    },

    confirmPurchase(payload) {
      const reqType = "구매확정"
      const orderId = payload.confirmPurchaseOrderId
      const paymentId = payload.confirmPurchasePaymentId
      this.reqChangeOrderStateToSpring({ reqType, orderId, paymentId })
    },
    returnProduct(payload) {
      const reqType = "반품신청"
      const orderId = payload.returnOrderId
      const paymentId = payload.returnPaymentId
      this.reqChangeOrderStateToSpring({ reqType, orderId, paymentId })
    },

    rangepayment(payload) {
      const readData = payload

      let token = window.localStorage.getItem('userInfo')
      this.reqReadRangePaymentList({ token, readData })
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