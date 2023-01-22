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
            v-for="(local, index) in localFlag.localMenu"
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
      localFlag : {
        localMenu :["서울경기","강원","충청","경상","전라","제주"],
        selectFlag :[false ,false ,false ,false ,false ,false]
      },
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
    async acquireFilteredProducts(index){
      if(this.localFlag.selectFlag[index] == true){
        this.localFlag.selectFlag[index] = false;
        this.allLocalProduct()
      }else{
        for (let i = 0; i < this.localFlag.selectFlag.length; i++) {
          this.localFlag.selectFlag[i] = false;
        }
        this.localFlag.selectFlag[index] = true;
        let localName = this.localFlag.localMenu[index]
        const alcoholType = this.$store.state.selectAlcoholType
        if(alcoholType =="all"){
          console.log("모든 알콜타입에서 지역 조회" + localName)
          await this.reqFilteredProductsFromSpring(localName)
        } else{
          console.log("받은 알코올타입과 지역 조회" + localName + alcoholType)
          await this.reqFilteredLocalAndAlcoholProductsFromSpring({alcoholType, localName})
        }
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
