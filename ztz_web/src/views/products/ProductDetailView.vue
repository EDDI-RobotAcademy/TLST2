<template>
  <div class="detailWrap">
      <product-detail-form
          :product="product"
      />
  </div>
</template>

<script>
import ProductDetailForm from "@/components/products/ProductDetailForm";
import {mapActions, mapState} from "vuex";

export default {
  name: "ProductDetailView",
  components: {ProductDetailForm},
  data () {
    return {
    }
  },
  methods: {
    ...mapActions([
        'requestProductFromSpring'
    ])
  },
  props: {
    productNo: {
      type: String,
      required: true
    }
  },
  computed: {
    ...mapState([
        'product'
    ])
  },
  created() {
    this.requestProductFromSpring(this.productNo)
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