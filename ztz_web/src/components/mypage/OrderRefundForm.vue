<template>
<div style="overflow-x: hidden;">
  <v-card class="pa-5">
    <h3>환불 요청</h3>

    <v-divider class="mt-1 mb-3"/>
    <p class="sub-header">환불 사유/필수</p>

    <v-row class="refund-row">
      <p class="cancel-title">고객 책임사유</p>
      <v-select v-bind:items="customerReason" v-model="refundReason" class="cancel-reason" outlined dense/>
    </v-row>
    <v-row class="refund-row">
      <p class="cancel-title">제품 책임사유</p>
      <v-select v-bind:items="productReason" v-model="refundReason" class="cancel-reason" outlined dense/>
    </v-row>

    <v-divider class="mt-1 mb-3"/>
    <p class="sub-header" >환불 금액</p>
    <p>총 환불 금액     {{refundPrice}} 원</p>
    <button-green btn-name="환불하기" style="margin-left: 130px" @click="refundOrder"/>
  </v-card>
</div>
</template>

<script>
import {mapActions} from "vuex";

export default {
  name: "OrderRefundForm",
  props:{
    refundPrice :Number,
    refundOrderId:Number,
    refundPaymentId:Number,
    allRefund:Boolean
  },
  data(){
    return{
      customerReason:['단순 변심' , '다른 제품 구매','더 나은 제품 발견',],
      productReason:['제품 파손' , '유통기한 초과', '제품 변질'],
      refundReason:'',

    }
  },
  methods:{
    ...mapActions([
      'reqRefundAllOrderToSpring',
      'reqRefundPortionOrderToSpring'
    ]),
    async refundOrder(){
      if(this.allRefund){ const {refundPaymentId,refundReason} = this


        await this.reqRefundAllOrderToSpring({refundPaymentId,refundReason})
      }
      alert("환불이 완료 되었습니다.")
      await this.$router.push("/")
    }
  }
}
</script>

<style scoped>
.sub-header{
  font-size: 14px;
}
.refund-row {
  padding: 12px;
}
.refund-row .cancel-reason{
  padding: 0px !important;
  max-width: 250px;
  font-size: 12px;
  min-height: 10px !important;
  max-height: 10px !important;
}
.refund-row .cancel-title{
  padding-left: 3px;
  padding-right: 6px;
  padding-top: 13px;
  font-size: 12px;
}
</style>