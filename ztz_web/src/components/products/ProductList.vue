<template>
<div>
  <paginate name="products" tag="ul" :list="products" :per="10" class="product-list">
    <li class="empty_product" v-if="!products || (Array.isArray(products) && products.length === 0)">
      <p>상품이 존재하지 않습니다.</p>
    </li>
    <li v-else v-for="product in paginated('products')" :key="product.productNo">
      <router-link :to="{ name: 'home'}">
        <product-card :product="product" ></product-card>
      </router-link>
    </li>
  </paginate>
  <paginate-links for="products" :simple="{
      next: 'Next »',
      prev: '« Back'
    }"></paginate-links>
</div>
</template>

<script>
import ProductCard from "@/components/products/ProductCard.vue";
import VuePaginate from 'vue-paginate'
import Vue from "vue";
Vue.use(VuePaginate)

export default {
  name: "ProductList",
  components: {ProductCard},
  props: {
    products: {
      type: Array
    }
  },
  data() {
    return {
      paginate: ['products']
    }
  },
}
</script>
