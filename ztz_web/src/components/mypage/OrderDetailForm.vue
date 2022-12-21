<template>
<div style="overflow-x: hidden;">
  <v-card>
    <p class="pl-3 pt-5">상세 주문 정보  <v-btn class="cancel-btn" @click="showAllCancelDialog(paymentList[paymentId-1].totalPaymentPrice)">결제 취소</v-btn></p>
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
      {{ paymentList[paymentId-1].address.city }}
      {{ paymentList[paymentId-1].address.street }}
      {{ paymentList[paymentId-1].address.addressDetail }}
      ({{ paymentList[paymentId-1].address.zipcode }})
    </p>
    </v-row>
    <v-divider class="mt-1 mb-3"/>
    <v-row>
      <p class="sub-title">요청사항 </p>
      <p class="content">
        {{ paymentList[paymentId-1].deliveryRequest }}
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
        <th>후기 작성</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="item in orderedList" :key="item">
        <td>
          <v-row>
            <img :src="require(`@/assets/products/uploadImg/${item.product.productInfo.thumbnailFileName}`)" class="ma-3" style="width: 70px">
            <v-col>
              <p class="product-brand">brand: {{item.product.brand}}</p>
              <p class="mt-0 pt-0">{{ item.product.name }}</p>
            </v-col>
          </v-row>
        </td>
        <td>{{ item.orderCnt * item.product.price}}</td>
        <td>{{ item.orderCnt }}</td>
        <td>{{ item.orderState }}</td>
        <td>
          <v-btn class="review-btn">후기 작성</v-btn>
        </td>
      </tr>
      </tbody>
    </v-simple-table>
  </v-card>

  <template>
    <v-dialog  v-model="refundDialog" width="400">
      <v-card>
        <order-refund-form :refundPrice="this.refundPrice"
                            :refundOrderId="this.orderId"
                            :refundPaymentId="this.paymentId"
                            :allRefund = "this.allRefund"/>
      </v-card>
    </v-dialog>
  </template>
</div>
</template>

<script>
import { mapState} from "vuex";
import OrderRefundForm from "@/components/mypage/OrderRefundForm";

export default {
  name: "OrderDetailForm",
  components: {OrderRefundForm},
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
    paymentId : Number
  },
  methods:{
    showAllCancelDialog(refundPrice){
      this.refundPrice = refundPrice
      this.refundDialog = true
      this.allRefund = true
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
.review-btn{
  font-size: 12px;
  max-height: 20px;
  max-width: 6px;
}
.product-brand{
  padding-top: 18px;
  padding-bottom: 0px;
  margin-bottom: 0px;
  font-size: 12px;
  color: #C9C9C9;
  font-weight: lighter;
}
.cancel-btn{
  font-size: 12px;
  max-height: 20px;
  max-width: 6px;
  margin-left: 600px;
}
</style>