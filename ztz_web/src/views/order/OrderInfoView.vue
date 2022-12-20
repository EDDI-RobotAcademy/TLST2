<template>
  <v-container class="mt-15">
    <order-info-form @submit="payment"/>
  </v-container>
</template>

<script>
import OrderInfoForm from "@/components/order/OrderInfoForm";
import {mapActions} from "vuex";

export default {
  name: "OrderInfoView",
  components: {
    OrderInfoForm,
  },
  methods:{
    ...mapActions([
      'reqRegisterOrderToSpring',
    ]),
    async payment(payload){
      const { paymentPrice, merchant_uid , sendInfo , imp_uid, city, street, addressDetail, zipcode ,sendRequest} = payload
      console.log(paymentPrice + merchant_uid + sendInfo , imp_uid ,city, street, addressDetail, zipcode ,sendRequest )

      await this.reqRegisterOrderToSpring(payload)

      alert("구매가 완료 되었습니다. 감사합니다.")
      await this.$router.push("/")
    }
  }

}
</script>

<style scoped>

</style>