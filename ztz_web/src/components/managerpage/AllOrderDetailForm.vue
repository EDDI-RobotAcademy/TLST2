<template>
<div style="overflow-x: hidden;">
  <v-card>
    <p class="pl-3 pt-5">상세 주문 정보 </p>
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
        <th v-if="paymentList[paymentListIndex].paymentState != 'PAYMENT_REFUND'">배송 관리</th>
        <th v-else>환불 사유</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="(item, index) in orderedList" :key="index">
        <td>
          <v-row>
            <img :src="require(`@/assets/products/uploadImg/${item.product.productInfo.thumbnailFileName}`)" class="ma-3" style="width: 70px">
            <v-col>
              <p class="product-brand">{{item.product.brand}}</p>
              <p class="mt-0 pt-0">{{ item.product.name }}</p>
            </v-col>
          </v-row>
        </td>
        <td>{{ item.orderPrice}}</td>
        <td>{{ item.orderCnt }}</td>
        <td>
          {{
            item.orderState == "PAYMENT_COMPLETE" ? "결제완료" :
                item.orderState == "PAYMENT_REFUND" ? "환불완료" :
                    item.orderState == "DELIVERY_ONGOING" ? "배송중" :
                        item.orderState == "DELIVERY_COMPLETE" ? "배송완료" :
                            item.orderState == "PAYMENT_CONFIRM" ? "구매확정" :
                                item.orderState == "REFUND_REQUEST" ? "반품신청" :
                                    "지정된 상태값이 없습니다"
          }}
        </td>
        <td>
<!--          상태가 결제완료, 배송중, 배송완료, 반품신청, 구매확정 , 환불완료 -->
          <p v-if="item.orderState == 'PAYMENT_REFUND'">{{orderedList[0].refundReason}}</p>
          <button-white v-else-if="item.orderState == 'PAYMENT_COMPLETE'"
                        class="deliveryBtn" btn-name="배송 시작"
                        @click="startDelivery(item.orderID, item.payment.paymentId, index)"/>
          <button-white v-else-if="item.orderState == 'DELIVERY_ONGOING'"
                        class="deliveryBtn" btn-name="배송 완료"
                        @click="finishDelivery(item.orderID, item.payment.paymentId)"/>
          <button-white v-else
                        class="deliveryBtn" btn-name="배송 완료"
                        :disabled="true"/>

        </td>
      </tr>
      </tbody>
    </v-simple-table>
  </v-card>

</div>
</template>

<script>
import { mapState} from "vuex";

export default {
  name: "AllOrderDetailForm",
  components: {},
  data(){
    return{
      refundDialog : false,
      refundPrice:0,
      orderId:0,

      allRefund:false
    }
  },
  computed:{
    ...mapState([
      'orderedList',
      'paymentList',
    ])
  },
  props:{
    paymentId : Number,
    paymentListIndex: Number,
  },
  methods:{
    startDelivery(orderId, paymentId, index){
      if(this.orderedList[index].orderState == '배송중'){
        alert("이미 배송중인 주문입니다.")
      }else{
        const startDeliveryOrderId = orderId
        const startDeliveryPaymentId = paymentId
        console.log("배송시작 에밋: "+ startDeliveryOrderId+ startDeliveryPaymentId)
        this.$emit('startDelivery', {startDeliveryOrderId, startDeliveryPaymentId})
      }
    },
    finishDelivery(orderId, paymentId){
      const finDeliveryOrderId = orderId
      const finDeliveryPaymentId = paymentId
      console.log("배송완료 에밋: "+ finDeliveryOrderId+ finDeliveryPaymentId)
      this.$emit('finDelivery', {finDeliveryOrderId, finDeliveryPaymentId})
    }
  }
}
</script>

<style scoped>
.sub-title{
  padding-top: 15px;
  font-weight: bold;
  padding-left: 25px;
  font-size: 14px;
  width: 100px;

}
.content{
  padding-top: 15px;
  padding-left: 50px;
  font-size: 14px;
}
.deliveryBtn{
  font-size: 12px;
  max-height: 20px;
  max-width: 6px;
  color: #205C37;
}
.refundReasonBtn{
  font-size: 12px;
  max-height: 20px;
  max-width: 6px;
  color: #E53935;
}
.product-brand{
  padding-top: 18px;
  padding-bottom: 0px;
  margin-bottom: 0px;
  font-size: 12px;
  color: #C9C9C9;
  font-weight: lighter;
}
</style>