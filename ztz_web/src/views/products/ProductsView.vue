<template>
  <div class="wrap productWrap">
    <div class="list-filter-area">
      <v-list flat>
        <v-list-item-group
          v-model="selectedItem"
          color="#205C37"
          style="display: flex; font-weight: 500"
        >
          <v-list-item
            v-for="(local, index) in localMenu"
            :key="index"
            @click="acquireFilteredProducts(index)"
            style="padding: 0 0 0 20px"
          >
            <v-list-item-content>
              <v-list-item-title v-text="local"> </v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </div>

    <product-list :products="products"></product-list>

  </div>
</template>

<script>
import "@/css/initialization.css";
import ProductCard from "@/components/products/ProductCard.vue";
import ProductList from "@/components/products/ProductList.vue";

import { mapState, mapActions } from "vuex";

export default {
  name: "productListView",
  components: {
    // eslint-disable-next-line vue/no-unused-components
    ProductCard,
    ProductList
  },
  data() {
    return{
      localMenu : ["서울경기","강원","충청","경상","전라","제주"],
      selectFlag: false
    }
  },
  computed: {
    ...mapState([
      'products', 'resMember', 'selectAlcoholType'
    ]),
  },
  mounted() {
    if(this.$store.state.isAuthenticated === true) {
      let token = window.localStorage.getItem('userInfo')
      this.reqMemberInfoToSpring(token)
    }
    console.log('products')
  },
  methods: {
    ...mapActions([
      'reqProductsFromSpring',
      'reqFilteredProductsFromSpring',
      'reqMemberInfoToSpring',
      'reqFilteredLocalAndAlcoholProductsFromSpring',
      'reqFilteredAlcoholProductsFromSpring'
    ]),
    async acquireFilteredProducts(index) {
      this.selectFlag = !this.selectFlag
      if(this.selectFlag){
        console.log("spring에서 아이템을 가져옵니다. : " + this.localMenu[index])
        let localName = this.localMenu[index]
        const alcoholType = this.$store.state.selectAlcoholType
        if(alcoholType =="all"){
          console.log("모든 알콜타입에서 지역 조회" + localName)
          await this.reqFilteredProductsFromSpring(localName)
        } else{
          console.log("받은 알코올타입과 지역 조회" + localName + alcoholType)
          await this.reqFilteredLocalAndAlcoholProductsFromSpring({alcoholType, localName})
        }
      } else{
        this.allLocalProduct()
      }
    },
    async allLocalProduct(){
      const alcoholType = this.$store.state.selectAlcoholType
      if(alcoholType =="all"){
        console.log("모든 알콜타입에서 모든 지역상품 조회")
        await this.reqProductsFromSpring()
      } else{
        console.log("받은 알코올 타입- 모든 지역 조회" + alcoholType)
        await this.reqFilteredAlcoholProductsFromSpring(alcoholType)
      }
    }
  },

}
</script>
