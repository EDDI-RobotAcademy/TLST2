<template>
  <v-container>
    <sign-up-form @submit="onSubmit"/>
  </v-container>
</template>

<script>

import axios from "axios";
import SignUpForm from "@/components/account/SignUpForm";

export default {
  name: "SignUpView",
  components: {
    SignUpForm
  },
  methods: {
    onSubmit (payload) {
      const { email, password, username, birthdate,  authorityNo, authorityName, managerCheck, managerCode, city, street , addressDetail , zipcode ,phoneNumber } = payload;

      axios.post("http://localhost:7777/ztz/member/sign-up", {
        email, password, username, birthdate, authorityNo, authorityName, managerCheck, managerCode, city, street , addressDetail , zipcode ,phoneNumber
      })
      .then((res) => {
        alert("회원 가입이 완료되었습니다.")
        console.log(res)
        this.$router.push("/sign-in")
      })
      .catch((res) => {
        alert(res.response.data.message)
      })
    }
  }
}
</script>

<style scoped>

</style>
