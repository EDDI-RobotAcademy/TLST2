<template>
  <div>
    <div class="head-area">
      <p class=" head-text">주문관리</p>
      <p>총 {{ lengthOfOrder }} 건</p>
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
        <tr v-for="paymentItem in paymentList" :key="paymentItem">
          <td class="pa-0" align="center">{{ paymentItem.merchant_uid }}</td>
          <td class="pl-9">{{ paymentItem.orderedCnt }}</td>
          <td>{{ paymentItem.totalPaymentPrice }}</td>
          <td>{{ paymentItem.paymentState }}</td>
          <td>{{ paymentItem.regData }}</td>
          <td>
            <v-btn class="orderedBtn" @click="showOrderDetails(paymentItem.paymentId)">
              상세정보
            </v-btn>
          </td>
        </tr>
        </tbody>
      </v-simple-table>
    </v-card>

    <template>
      <v-dialog v-model="showOrderDetail" width="800">
        <order-detail-form :paymentId="this.paymentId"/>
      </v-dialog>
    </template>
  </div>
</template>


<script>
import {mapActions, mapState} from "vuex";
import OrderDetailForm from "@/components/mypage/OrderDetailForm";

export default {
  name: "OrderManagement",
  components: {OrderDetailForm},
  data() {
    return {
      showOrderDetail: false,
      lengthOfOrder: 0,

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
      this.lengthOfOrder = this.$store.state.paymentList.length;
    } else {
      alert("로그인 상태가 아닙니다.")
    }
  },
  methods: {
    ...mapActions([
      'reqPaymentListFromSpring',
      'reqOrderedListFromSpring'
    ]),
    async showOrderDetails(paymentId) {
      this.paymentId = paymentId
      this.showOrderDetail = true
      await this.reqOrderedListFromSpring(paymentId)
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