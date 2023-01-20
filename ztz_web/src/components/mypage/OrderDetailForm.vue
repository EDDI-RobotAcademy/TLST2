<template>
  <div style="overflow-x: hidden;">
    <v-card>
      <p class="pl-3 pt-5">상세 주문 정보
        <v-btn class="cancel-btn" v-if="paymentList[paymentListIndex].paymentState == 'PAYMENT_COMPLETE'"
               @click="refundBtn(paymentList[paymentListIndex].totalPaymentPrice)">결제 취소
        </v-btn>
      </p>
      <v-divider class="mt-1 mb-3"/>
      <v-row>
        <p class="sub-title">수령인 </p>
        <p class="content">{{ orderedList[0].member.username }}</p>
      </v-row>

      <v-divider class="mt-1 mb-3"/>
      <v-row>
        <p class="sub-title">주문날짜 </p>
        <p class="content">
          {{ orderedList[0].payment.regData }}
        </p>
      </v-row>
      <v-divider class="mt-1 mb-3"/>
      <v-row>
        <p class="sub-title">배송지 </p>
        <p class="content">
          {{ paymentList[paymentListIndex].address.city }}
          {{ paymentList[paymentListIndex].address.street }}
          {{ paymentList[paymentListIndex].address.addressDetail }}
          ({{ paymentList[paymentListIndex].address.zipcode }})
        </p>
      </v-row>
      <v-divider class="mt-1 mb-3"/>
      <v-row>
        <p class="sub-title">요청사항 </p>
        <p class="content">
          {{ paymentList[paymentListIndex].deliveryRequest }}
        </p>
      </v-row>
      <v-divider class="mt-1 mb-3"/>

      <p class="sub-title">제품 정보</p>
      <v-simple-table>
        <thead>
        <tr align="center">
          <th>상품 정보</th>
          <th>주문 금액</th>
          <th>수량</th>
          <th>상태</th>
          <th>구매확정관리</th>
          <th>리뷰관리</th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="(item, index) in orderedList" :key="index">
          <td>
            <v-row>
              <img :src="require(`@/assets/products/uploadImg/${item.product.productInfo.thumbnailFileName}`)"
                   class="ma-3" style="width: 70px">
              <v-col>
                <p class="product-brand">{{ item.product.brand }}</p>
                <p class="mt-0 pt-0">{{ item.product.name }}</p>
              </v-col>
            </v-row>
          </td>
          <td>{{ item.orderPrice | numberFormat }}원</td>
          <td>{{ item.orderCnt }}</td>
          <td>
            {{
              item.orderState == "PAYMENT_COMPLETE" ? "결제완료" :
                  item.orderState == "PAYMENT_REFUND" ? "환불완료" :
                      item.orderState == "DELIVERY_START" ? "배송시작" :
                          item.orderState == "PART_DELIVERY_ONGOING" ? "부분배송중" :
                              item.orderState == "DELIVERY_ONGOING" ? "배송중" :
                                  item.orderState == "DELIVERY_COMPLETE" ? "배송완료" :
                                      item.orderState == "PAYMENT_CONFIRM" ? "구매확정" :
                                          item.orderState == "REFUND_REQUEST" ? "반품신청" :
                                              item.orderState == "WRITE_REVIEW" ? "리뷰작성 완료" :
                                                  item.orderState == "PART_WRITE_REVIEW" ? "일부리뷰 작성 완료" :
                                                      item.orderState == "ABLE_WRITE_REVIEW" ? "리뷰작성가능" :
                                              "지정된 상태값이 없습니다"
            }}
          </td>
          <td>
            <v-row>
              <button-green v-if="item.orderState == 'DELIVERY_COMPLETE'"
                            @click="confirmPurchaseBtn(item.orderID, item.payment.paymentId)"
                            class="review-btn ma-2" btn-name="구매 확정"/>
              <button-green v-else
                            :disabled="true" class="review-btn ma-2" btn-name="구매 확정"/>
            </v-row>
            <v-row>
              <button-white v-if="item.orderState == 'DELIVERY_COMPLETE'"
                            @click="returnProductBtn(item.orderID, item.payment.paymentId)"
                            class="review-btn ma-2" btn-name="반품 신청"/>
              <button-white v-else
                            :disabled="true" class="review-btn ma-2" btn-name="반품 신청"/>
            </v-row>
          </td>
          <td>
            <!--          리뷰메소드 연결 필요-->
            <button-white v-if="item.orderState == 'PAYMENT_CONFIRM'||item.orderState =='REFUND_REQUEST'"
                          class="review-btn ma-2" btn-name="리뷰 작성"
                          @click="showReviewDialog(item.product.productNo , item.orderID)"/>
            <button-white v-else
                          :disabled="true"
                          class="review-btn ma-2" btn-name="리뷰 작성"/>
            <template>
              <v-dialog v-model="reviewDialog" width="650">
                <ReviewRegisterForm :product="product" :orderInfo="orderInfo"/>
              </v-dialog>
            </template>
          </td>
        </tr>
        </tbody>
      </v-simple-table>
    </v-card>

    <template>
      <v-dialog v-model="refundDialog" width="400">
        <v-card>
          <order-refund-form :refundPrice="this.refundPrice"
                             :refundOrderId="this.orderId"
                             :refundPaymentId="this.paymentId"
                             :allRefund="this.allRefund"/>
        </v-card>
      </v-dialog>
    </template>
  </div>
</template>

<script>
import {mapActions, mapState} from "vuex";
import OrderRefundForm from "@/components/mypage/OrderRefundForm";
import ReviewRegisterForm from "@/components/products/review/ReviewRegisterForm";

export default {
  name: "OrderDetailForm",
  components: {ReviewRegisterForm, OrderRefundForm},
  data() {
    return {
      reviewDialog: false,
      refundDialog: false,
      refundPrice: 0,
      orderId: 0,
      allRefund: false,
      startDeliveryNum: 0,
    }
  },
  computed: {
    ...mapState([
      'orderedList',
      'paymentList',
      'product',
      'orderInfo'
    ])
  },
  props: {
    paymentId: Number,
    paymentListIndex: Number
  },
  methods: {
    ...mapActions(['requestProductFromSpring', 'reqOrderInfoById']),
    // 배송중 상태인 주문리스트 존재하는 경우 결제취소 버튼 클릭 시 환불불가 메시지 출력
    refundBtn(refundPrice) {
      this.startDeliveryNum = 0
      for (let i = 0; i < this.orderedList.length; i++) {
        if (this.orderedList[i].orderState == '배송중') {
          this.startDeliveryNum += 1
        }
      }
      if (this.startDeliveryNum > 0) {
        alert("배송중인 상품이 있어 환불이 불가합니다. 상품QnA에 문의해주세요")
      } else {
        this.showAllCancelDialog(refundPrice)
      }
    },
    // 상태가 결제완료, 배송중, 배송완료, 반품신청, 구매확정 , 환불완료
    confirmPurchaseBtn(orderId, paymentId) {
      const confirmPurchaseOrderId = orderId
      const confirmPurchasePaymentId = paymentId
      this.$emit('confirmPurchase', {confirmPurchaseOrderId, confirmPurchasePaymentId})

    },
    returnProductBtn(orderId, paymentId) {
      const returnOrderId = orderId
      const returnPaymentId = paymentId
      this.$emit('returnProduct', {returnOrderId, returnPaymentId})
    },
    showAllCancelDialog(refundPrice) {
      this.refundPrice = refundPrice
      this.refundDialog = true
      this.allRefund = true
    },
    async showReviewDialog(productNo, orderNo) {
      this.reviewDialog = true
      await this.requestProductFromSpring(productNo)
      await this.reqOrderInfoById(orderNo)
    },
  }
}
</script>

<style scoped>
.sub-title {
  padding-top: 15px;
  font-weight: bold;
  padding-left: 25px;
  font-size: 14px;
  width: 100px;

}

.content {
  padding-top: 15px;
  padding-left: 50px;
  font-size: 14px;
}

.review-btn {
  font-size: 12px;
  max-height: 20px;
  max-width: 6px;
}

.review-btn {
  font-size: 12px;
  max-height: 20px;
  max-width: 6px;
}

.product-brand {
  padding-top: 18px;
  padding-bottom: 0px;
  margin-bottom: 0px;
  font-size: 12px;
  color: #C9C9C9;
  font-weight: lighter;
}

.cancel-btn {
  font-size: 12px;
  max-height: 20px;
  max-width: 6px;
  margin-left: 800px;
}
</style>