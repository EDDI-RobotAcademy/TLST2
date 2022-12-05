<template>
  <div class="detailWrap">
    <product-detail-form/>
  </div>

</template>

<script>
import ProductDetailForm from "@/components/products/ProductDetailForm";
export default {
  name: "ProductDetailView",
  components: {ProductDetailForm},
  computed: {
    //mapState - product
  },
  created() {
    // 스프링에 상품 정보 요청하기 - requestProductFromSpring(productNo)
  }
}
</script>

<style scoped>
.detailWrap {
  width: 1200px;
  margin: 0 auto;
  padding: 40px 0;
}

</style>