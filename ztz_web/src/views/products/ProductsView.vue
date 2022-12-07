<template>
 <div class="listWrap">
   <div class="list-filter-area">
     <p>모든 상품</p>
     <div class="local-filter">
       <ul>
       <li>
         <button @click="reqProductsFromSpring">All</button>
       </li>
     </ul>
       <ul>
         <li v-for="(local, index) in localMenu" :key="index">
           <button @click="acquireFilteredProducts(index)" :value="index">{{ local }}</button>
         </li>
       </ul>
     </div>
   </div>

    <product-list :products="products"></product-list>

 </div>
</template>

<script>
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
    }
  },
  computed: {
    ...mapState([
      'products'
    ]),
  },
  mounted() {
    this.reqProductsFromSpring()
    console.log('products')
  },
  methods: {
    ...mapActions([
      'reqProductsFromSpring',
      'reqFilteredProductsFromSpring'
    ]),
    async acquireFilteredProducts(index) {
      console.log("spring에서 아이템을 가져옵니다. : " + this.localMenu[index])
      let localName = this.localMenu[index]
      await this.reqFilteredProductsFromSpring(localName)
    },
  },

}
</script>
