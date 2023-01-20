<template>
  <div>
    <v-divider class="mt-3 mb-3" @submit.prevent="ProductInfoSubmit" />
    <p align="left">상품 정보</p>

      <v-simple-table border="1">
        <thead>
          <tr>
            <th class="text-left">상품 정보</th>
            <th class="text-left">수량</th>
            <th class="text-left">주문금액</th>
          </tr>
        </thead>
        <tbody v-if="this.orderList.orderSave.directOrderCheck">
          <tr v-for="item in orderList" :key="item.tmpCartItemOrderNo">
            <td>
              <v-row class="mt-5 mb-3 ml-10">
                <img
                  :src="
                    require(`@/assets/products/uploadImg/${item.product.productInfo.thumbnailFileName}`)
                  "
                  style="width: 60px"
                />
                <p class="product-info mt-7 ml-2">{{ item.product.name }}</p>
              </v-row>
            </td>
            <td class="product-info">{{ item.quantity}}개</td>
            <td v-if="item.product.monthAlcoholCheck" class="product-info">
              <span style="width: 61px; display: inline-block; text-align: right">
                {{ item.product.price * item.quantity  | numberFormat}}원
              </span><br>
              <span>
                <del style="color: #BDBDBD; width: 60px; display: inline-block; font-size: 12px; text-align: right">
                  {{ (item.product.price /0.9) * item.quantity  | numberFormat}}원
                </del>
              </span>
            </td>
            <td v-else class="product-info">{{ item.product.price  | numberFormat}}원</td>
          </tr>
        </tbody>

        <tbody v-else>
          <tr v-for="item in orderList.orderSave.selectList" :key="item.index">
            <td>
              <v-row class="mt-5 mb-3">
                <img
                  :src="
                    require(`@/assets/products/uploadImg/${item.product.productInfo.thumbnailFileName}`)
                  "
                  style="width: 60px"
                />
                <p class="product-info mt-7 ml-8">{{ item.product.name }}</p>
              </v-row>
            </td>
            <td class="product-info">{{ item.count }}개</td>
            <td v-if="item.product.monthAlcoholCheck == true" class="product-info">
              <span style="width: 61px; display: inline-block; text-align: right">
                {{ item.product.price * item.count  | numberFormat}}원</span><br>
              <span>
                <del style="color: #BDBDBD; width: 60px; display: inline-block; font-size: 12px; text-align: right">
                  {{ item.product.price * item.count /0.9  | numberFormat}}원
                </del>
              </span>
            </td>
            <td v-else class="product-info">
              {{ item.product.price * item.count  | numberFormat}}원
            </td>
          </tr>
        </tbody>
      </v-simple-table>

    <ul class="product-explanation">
      <li>
        해외 배송 상품이나 일부 업체의 경우, 교환/환불 시 반송료가 다를 수
        있으며 상품 페이지에 별도 표기되어 있습니다.
      </li>
      <li>2개 이상의 브랜드(업체) 상품을 주문하신 경우, 각 개별 배송됩니다.</li>
    </ul>
  </div>
</template>

<script>
import { mapState } from "vuex";

export default {
  name: "OrderProductInfo",
  data() {
    return {
      totalPrice: 0,
      totalCount: 0,
    };
  },
  computed: {
    ...mapState(["orderList"]),
  },
  created() {
    this.totalPrice = this.$store.state.orderList.orderSave.totalPrice;
    if (this.orderList.orderSave.directOrderCheck) {
      //바로 구매일 경우
      this.totalCount = 1;
    } else {
      //바로 구매아니고 선택 구매, 전체구매일 경우
      this.totalCount = Object.keys(
        this.$store.state.orderList.orderSave.selectList
      ).length;
    }

    this.onProductInfoSubmit();
  },
  methods: {
    onProductInfoSubmit() {
      console.log("왜안함?" + this.totalCount + this.totalPrice);

      const { totalCount, totalPrice } = this;
      this.$emit("submit", { totalCount, totalPrice });
    },
  },
};
</script>

<style scoped>
.product-explanation {
  margin-top: 17px;
  font-size: 15px;
  color: gray;
}
.product-info-card .product-info {
  font-size: 15px;
  font-weight: bold;
}
</style>
