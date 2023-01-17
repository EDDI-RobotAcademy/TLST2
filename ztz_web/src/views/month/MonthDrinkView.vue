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
          :src="require('@/assets/banner/month_banner.png')">
      </v-img>
    </div>
    <div class="item-title">
      <div>
        <span>전체 상품 {{ products.length }}개</span>
      </div>
    </div>
    <v-divider style="border-width: 1px; border-color: black"></v-divider>
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
        'reqMonthAlcoholProductsFromSpring'
    ])
  },
  computed: {
    ...mapState([
        'products'
    ])
  },
  mounted() {
    this.reqMonthAlcoholProductsFromSpring()
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

.item-title {
  display: flex;
  justify-content: space-between;
  margin: 30px 0 10px 0;
}

</style>