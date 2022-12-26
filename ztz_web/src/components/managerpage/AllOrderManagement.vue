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
        <tr v-else v-for="(paymentItem, index) in paymentList" :key="index">
          <td class="pa-0" align="center">{{ paymentItem.merchant_uid }}</td>
          <td class="pl-9">{{ paymentItem.orderedCnt }}</td>
          <td>{{ paymentItem.totalPaymentPrice }}</td>
          <td>{{ paymentItem.paymentState }}</td>
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
      <v-dialog v-model="showOrderDetail" width="800">
        <all-order-detail-form :paymentId="this.paymentId"
                               :paymentListIndex="this.paymentListIndex"
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