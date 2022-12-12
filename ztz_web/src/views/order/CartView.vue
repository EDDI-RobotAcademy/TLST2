<template>
  <div class="detailWrap mt-15" >
   <cart-form/>
  </div>
</template>

<script>

import CartForm from "@/components/order/CartForm";
import {mapActions} from "vuex";

export default {
  name: "CartView",
  components: {
    CartForm
  },
  methods:{
    ...mapActions([
      'reqCartListFromSpring',
    ]),
  },
  mounted() {
    if(this.$store.state.isAuthenticated === true) {
      let token = window.localStorage.getItem('userInfo')
      this.reqCartListFromSpring(token)
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