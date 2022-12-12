<template>
  <div>
    <v-divider class="mt-3 mb-3"/>
    <p align="left">상품 정보</p>

    <v-card class="product-info-card" outlined>
      <v-simple-table border="1">
        <thead>
        <tr>
          <th class="text-left">
            상품 정보
          </th>
          <th class="text-left">
            수량
          </th>
          <th class="text-left">
            배송비
          </th>
          <th class="text-left">
            주문금액
          </th>
        </tr>
        </thead>
        <tbody v-if="this.orderList.orderSave.directOrderCheck">
        <tr v-for="item in orderList" :key="item.tmpCartItemOrderNo">
          <td>
            <v-row class="mt-5 mb-3">
              <img :src="require(`@/assets/products/defaultImg/${item.product.productInfo.thumbnailFileName}`)"
                   style="width: 60px"
              >
              <p class="product-info mt-7 ml-2">{{ item.product.name}}</p>
            </v-row>
          </td>
          <td class="product-info"  >{{item.quantity}}개</td>
          <td class="product-info"  >무료</td>
          <td class="product-info"  >{{item.product.price}}원</td>
        </tr>
        </tbody>

        <tbody v-else>
        <tr v-for="item in orderList.orderSave.selectList" :key="item.index">
          <td>
            <v-row class="mt-5 mb-3">
              <img :src="require(`@/assets/products/defaultImg/${item.product.productInfo.thumbnailFileName}`)"
                   style="width: 60px"
              >
              <p class="product-info mt-7 ml-2">{{ item.product.name}}</p>
            </v-row>
          </td>
          <td class="product-info"  >{{item.count}}개</td>
          <td class="product-info"  >무료</td>
          <td class="product-info"  >{{item.product.price}}원</td>
        </tr>
        </tbody>
      </v-simple-table>
    </v-card>

    <!--    총 합계 추가 -->
    <div class="row" style="margin-top: 60px; margin-left: 30px; font-size: 25px; font-weight: bold;">
      <p class="col-sm-4" style="text-align: right; color: #205c37">총 합계</p>
      <div class="col-sm-8" align="center" style=" color: #205c37">
        <p>{{ this.totalPrice | numberFormat }} 원</p>
      </div>
    </div>


    <ul class="product-explanation">
      <li>ztz 스토어는 기본적으로 대한민국 내 제주도 및 도서 산간 지역 포함 전 지역, 전 상품 무료배송입니다.</li>
      <li>해외 배송 상품이나 일부 업체의 경우, 교환/환불 시 반송료가 다를 수 있으며 상품 페이지에 별도 표기되어 있습니다.</li>
      <li>2개 이상의 브랜드(업체) 상품을 주문하신 경우, 각 개별 배송됩니다.</li>
    </ul>
  </div>
</template>

<script>
import {mapState} from "vuex";

export default {
  name: "OrderProductInfo",
  data(){
    return{

      totalPrice: 0,
      totalCount: 0,

    }
  },
  created() {
    this.totalPrice =this.$store.state.orderList.orderSave.totalPrice
    if(this.orderList.orderSave.directOrderCheck){ //바로 구매일 경우
      this.totalCount = 1
    }else {  //바로 구매아니고 선택 구매, 전체구매일 경우
      this.totalCount = Object.keys(this.$store.state.orderList.orderSave.selectList).length
    }
  },
  computed : {
    ...mapState([
      'orderList'
    ])
  },
  filters: {
    numberFormat(val) {
      return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  },
}
</script>

<style scoped>
.product-explanation{
  font-size: 9px;
  color: #C9C9C9;
  font-weight: lighter;
}
.product-info-card .product-info{
  font-size: 12px;
  font-weight: bold;
}
</style>