<template>
  <div class="detailWrap">
    <product-register-form class="mt-15"
    />
  </div>
</template>

<script>

import ProductRegisterForm from "@/components/products/ProductRegisterForm";

export default {
  name: "ProductDetailView",
  components: {ProductRegisterForm},
  props: {
  },
  computed: {
  },
  created() {
  },
  methods: {
  },

}
</script>

<style scoped>
.detailWrap {
  width: 1200px;
  margin: 0 auto;
  padding: 40px 0;
}

</style>
