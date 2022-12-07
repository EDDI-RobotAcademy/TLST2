<template>
  <v-container class="mt-15">
    <order-info-form/>
  </v-container>
</template>

<script>
import OrderInfoForm from "@/components/order/OrderInfoForm";

export default {
  name: "OrderInfoView",
  components: {
    OrderInfoForm,
  }

}
</script>

<style scoped>

</style>