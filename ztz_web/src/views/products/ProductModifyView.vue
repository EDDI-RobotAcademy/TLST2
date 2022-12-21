<template>
  <div class="detailWrap">
    <product-modify-form class="mt-15" :product="product"
    />
  </div>
</template>

<script>


import ProductModifyForm from "@/components/products/ProductModifyForm";
import {mapActions, mapState} from "vuex";

export default {
  name: "ProductModifyView",
  components: {ProductModifyForm},
  props: {
    productNo: {
      type: String,
      required: true
    }
  },
  computed: {
    ...mapState(['product', 'local', 'alcoholType'])
  },
  created() {
    this.requestProductFromSpring(this.productNo)
    this.requestProductLocalAndTypeFromSpring(this.productNo)
  },
  methods: {
    ...mapActions([
      'requestProductFromSpring', 'requestProductLocalAndTypeFromSpring',
    ]),
      onSubmit(){

    }
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
