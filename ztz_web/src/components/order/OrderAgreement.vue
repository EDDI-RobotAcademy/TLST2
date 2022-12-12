<template>
  <div>
    <v-divider class="mt-3 mb-3"/>
    <p align="left">결제 정보/주문자 동의</p>
    <v-card class="member-info-card" outlined>

      <v-row class="member-row" >
        <p class="member-tool" align="left">품절시 환불 안내</p>
        <p class="member-info">결제하신 수단으로 취소 됩니다.</p>
      </v-row>
      <ul class="refund-explanation">
        <li>입점업체 배송은 낮은 확률로 상품이 품절일 가능성이 있습니다. 이에 품절 시 빠르게 환불 처리해드립니다.</li>
        <li>현금 환불의 경우, 예금정보가 일치해야 환불 처리가 가능합니다. 은행명, 계좌번호, 예금주명을 정확히 기재 부탁드립니다.</li>
        <li> 환불 받으신 날짜 기준으로 3~5일(주말 제외) 후 결제대행사에서 직접 고객님의 계좌로 환불 처리됩니다.</li>
      </ul>
      <v-divider class="mt-1 mb-3"/>

      <v-row class="member-row" >
        <p class="member-tool" align="left">주문자 동의</p>
        <p class="member-info">회원 본인은 구매 조건, 주문 내용 및 결제에 동의 합니다.</p>
      </v-row>
      <ul type="none" class="refund-explanation">
        <li>개인 정보 수집 및 이용 동의 <a @click="showCollectionCardMethod">자세히</a> </li>
        <v-card v-if="showCollectionCard" class="explanationCard">
          <strong>개인정보</strong> 수집 및 이용 동의<br>
          1. 수집목적<br>
          판매자와 구매자의 거래의 원활한 진행, 본인의사의 확인, 고객 상담 및 불만처리, 상품과 경품 배송을 위한 배송지 확인 등<br>
          2. 수집 항목<br>
          구매자 정보: 성명, 전화번호, ID, 휴대전화 번호, 메일주소, 상품 구매정보<br>
          수령자 정보: 성명, 전화번호, 휴대전화 번호, 배송지 주소<br>
          3. 보유기간<br>
          개인정보 수집 및 이용목적 달성 시 및 관련 법령에 따른 기간까지 보관<br>
          4. 동의 거부시 불이익<br>
          본 개인정보 수집 및 이용 등에 동의하지 않을 권리가 있습니다. 다만, 필수항목에 동의를 하지 않을경우 거래가 제한될 수 있습니다.<br>
        </v-card>

        <li>개인정보 제3자 제공 동의 <a @click="showFurnishCardMethod">자세히</a> </li>
        <v-card v-if="showFurnishCard" class="explanationCard">
          <p>무신사의 회원계정으로 상품 및 서비스를 구매하고자 할 경우,<br> (주)무신사는 거래 당사자간 원활한 의사소통 및 배송,
            상담 등 거래이행을 위하여 필요한 최소한의 개인정보만을 무신사 입점업체 판매자 및 배송업체에 아래와 같이 공유하고 있습니다.</p>

          1. (주)무신사는 귀하께서 무신사 입점업체 판매자로부터 상품 및 서비스를 구매하고자 할 경우, 개인정보보호법 제 17조 (개인정보의 제공)에 따라 아래와 같은 사항은 안내하고 동의를 받아 귀하의 개인정보를 판매자에게 공유합니다.<br>
          2. 개인정보를 공유받는자 : 주식회사 패션링크<br>
          3. 공유하는 개인정보 항목 - 구매자 정보: 성명, 전화번호, ID, 휴대전화 번호, 메일주소, 상품 구매정보 - 수령자 정보: 성명, 전화번호, 휴대전화 번호, 배송지 주소<br>
          4. 개인정보를 공유받는 자의 이용 목적 : 판매자와 구매자의 거래의 원활한 진행, 본인의사의 확인, 고객 상담 및 불만처리, 상품과 경품 배송을 위한 배송지 확인 등<br>
          5. 개인정보를 공유받는 자의 개인정보 보유 및 이용 기간 : 상품 구매/배송/반품 등 서비스 처리 완료 후 180일간 보관 후 파기<br>
          6. 동의 거부 시 불이익 : 본 개인정보 공유에 동의하지 않으시는 경우, 동의를 거부할 수 있으며, 이 경우 거래가 제한됩니다.<br>

        </v-card>

        <li>전자결제대행 이용 동의 <a @click="showPaymentCardMethod">자세히</a> </li>
        <v-card v-if="showPaymentCard" class="explanationCard">
          <strong>개인정보</strong> 수집 및 이용 동의<br>
          1. 수집목적<br>
          판매자와 구매자의 거래의 원활한 진행, 본인의사의 확인, 고객 상담 및 불만처리, 상품과 경품 배송을 위한 배송지 확인 등<br>
          2. 수집 항목<br>
          구매자 정보: 성명, 전화번호, ID, 휴대전화 번호, 메일주소, 상품 구매정보<br>
          수령자 정보: 성명, 전화번호, 휴대전화 번호, 배송지 주소<br>
          3. 보유기간<br>
          개인정보 수집 및 이용목적 달성 시 및 관련 법령에 따른 기간까지 보관<br>
          4. 동의 거부시 불이익<br>
          본 개인정보 수집 및 이용 등에 동의하지 않을 권리가 있습니다. 다만, 필수항목에 동의를 하지 않을경우 거래가 제한될 수 있습니다.<br>
        </v-card>

      </ul>
      <v-divider class="mt-1 mb-3"/>

      <v-row class="member-row" >
        <p class="member-tool" align="left">총금액</p>
        <p class="member-info">{{ this.TotalPaymentAmount }}원</p>
      </v-row>

    </v-card>
  </div>
</template>

<script>
export default {
  name: "OrderAgreement",
  props:{
    TotalPaymentAmount : String
  },
  data(){
    return{
      showCollectionCard:false,
      showFurnishCard:false,
      showPaymentCard:false
    }
  },
  methods:{
    showCollectionCardMethod(){
      this.showCollectionCard = !this.showCollectionCard
    },
    showFurnishCardMethod(){
      this.showFurnishCard = !this.showFurnishCard
    },
    showPaymentCardMethod(){
      this.showPaymentCard = !this.showPaymentCard
    }
  }
}
</script>

<style scoped>
.member-info-card .member-row {
  margin-top: 10px;
  margin-left: 20px;
}
.member-info-card .member-row .member-tool{
  font-size: 12px;
  font-weight: bold;
  width: 170px;
  margin-right: 0px;
  padding-right: 0px;
}
.member-info-card .member-row .member-info{
  font-size: 12px;
}
.refund-explanation{
  font-size: 12px;
  font-weight: lighter;
  margin-left: 165px;
}
.refund-explanation .explanationCard{
  overflow-y: scroll;
  max-height: 80px;
  padding: 5px;
  font-size: 10px;
}
</style>