<template>
  <div class="month-wrap">
    <div class="month-title">
      <h2>이달의 술</h2>
    </div>
    <div class="month-banner">
      <v-img
          contain
          max-width="1200px"
          max-height="500px"
          :src="require('@/assets/banner/banner_05.png')">
      </v-img>
    </div>
    <div>
      <month-drink-product-list :products="products"/>
    </div>
  </div>
</template>

<script>
import {mapActions, mapState} from "vuex";
import MonthDrinkProductList from "@/components/month/MonthDrinkProductList";
export default {
  name: "MonthDrinkView",
  components: {MonthDrinkProductList},
  methods: {
    ...mapActions([
      // 관리자가 등록된 상품 중 선택하여 이달의 술로 배치할 예정
      // 일단 상품 리스트 불러옴
        'reqProductsFromSpring'
    ])
  },
  computed: {
    ...mapState([
        'products'
    ])
  },
  mounted() {
    // 관리자가 등록된 상품 중 선택하여 이달의 술로 배치할 예정
    // 일단 상품 리스트 불러옴
    this.reqProductsFromSpring()
  }
}
</script>

<style scoped>
.month-wrap {
  width: 1200px;
  margin: 0 auto;
  padding: 40px 0;
}

.month-title {
  text-align: center;
}

.month-banner {
  margin-top: 20px;
}

</style>