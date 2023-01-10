<template>
  <div class="mt-5 ml-5">
    <div class="head-area">
      <p class=" head-text">상품관리</p>
    </div>
      <div class="item-title">
        <v-row>
          <div class="ml-3 mt-5">
            전체 상품 {{ products.length }}개
          </div>
          <div class="ml-5">
            <button-white @click="registerProduct" btn-name="상품 등록"/>
          </div>
        </v-row>
      </div>
      <div class="item mt-5">
        <div>
          <v-row>
            <v-col cols="auto" v-for="(item, idx) in products" :key="idx">

                <v-card width="200px" height="400px">
                  <v-card-text style="padding: 20px 0 0 0">
                  <v-img
                      :src="require(`@/assets/products/uploadImg/${item.productInfo.thumbnailFileName}`)"
                      max-width="250px"
                      max-height="200px"
                      contain/>
                  </v-card-text>
                  <div class="item-info">
                    <router-link
                        style="text-decoration: none"
                        :to="{ name: 'ProductDetailView',
                                params: { productNo: item.productNo.toString() }}">
                    <p style="color: #568869; font-size: 14px;">{{ item.brand }}</p>
                    <p style="color: #4d5450">{{ item.name }}</p>
                    <p style="color: #222222; font-weight: bold; font-size: 14px">{{ item.price | numberFormat }} 원</p>
                    </router-link>
                    <button-green @click="CheckMonthAlcohol(item.productNo)" v-if="!item.monthAlcoholCheck"
                                  class="mt-2" small
                                  btn-name="이달의 술 등록"
                                  icon-name="mdi-diamond-stone"/>
                    <button-white @click="CheckMonthAlcohol(item.productNo)" v-else
                                  class="mt-2 ml-0" small
                                  btn-name="이달의 술 해제"
                                  icon-name="mdi-diamond-stone"/>
                  </div>
                </v-card>
            </v-col>
          </v-row>
        </div>
      </div>
    </div>

</template>

<script>
import {mapActions, mapState} from "vuex";

export default {
  name: "ProductManagementList",
  // props: {
  //   products: Array
  // },
  methods: {
    ...mapActions([
      'reqProductsFromSpring', 'reqCheckMonthAlcoholToSpring'
    ]),
    registerProduct(){
      this.$router.push({name: 'ProductRegisterView'})
      alert("상품등록 페이지로 이동합니다.")
    },
    CheckMonthAlcohol(productNo){
      this.reqCheckMonthAlcoholToSpring(productNo)
    }
  },
  computed: {
    ...mapState([
      'products'
    ])
  },
  mounted() {
    this.reqProductsFromSpring()
  }
}
</script>

<style scoped>

.month-items {
  margin-top: 30px;
}
.month-items .item-title {
  display: flex;
  justify-content: space-between;
  margin-bottom: 10px;
}

.month-items .item {
  margin-top: 30px;
}

.item .item-info {
  margin: 15px 0 0 20px;
}

.item .item-info p {
  margin: 6px;
}


</style>