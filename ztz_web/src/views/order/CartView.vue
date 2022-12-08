<template>
  <div class="detailWrap mt-15" >
   <cart-form/>
  </div>
</template>

<script>

import CartForm from "@/components/order/CartForm";

export default {
  name: "CartView",
  components: {
    CartForm
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