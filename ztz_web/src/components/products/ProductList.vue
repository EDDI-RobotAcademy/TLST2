<template>
  <div>
    <ul class="product-list">
      <li
        class="empty_product"
        v-if="!products || (Array.isArray(products) && products.length === 0)"
      >
        <p>상품이 존재하지 않습니다.</p>
      </li>
      <li v-for="(product, index) in calData" :key="index">
        <router-link
          :to="{
            name: 'ProductDetailView',
            params: { productNo: product.productNo.toString() },
          }"
        >
          <product-card :product="product"></product-card>
        </router-link>
      </li>
    </ul>

    <v-pagination
      v-model="curPageNum"
      :length="numOfPages"
      color="#2c4636"
      class="mt-10"
      flat
    ></v-pagination>
  </div>
</template>

<script>
import ProductCard from "@/components/products/ProductCard.vue";

export default {
  name: "ProductList",
  components: { ProductCard },
  props: {
    products: {
      type: Array,
    },
  },
  data() {
    return {
      listData: ["products"],
      dataPerPage: 8,
      curPageNum: 1,
    };
  },
  methods: {},
  computed: {
    startOffset() {
      return (this.curPageNum - 1) * this.dataPerPage;
    },
    endOffset() {
      return this.startOffset + this.dataPerPage;
    },
    numOfPages() {
      return Math.ceil(this.products.length / this.dataPerPage);
    },
    calData() {
      return this.products.slice(this.startOffset, this.endOffset);
    },
  },
};
</script>
