<template>
  <div class="mt-5 ml-5">
    <div class="head-area " >
      <p class=" head-text">배송관리</p>
    </div>

    <div>
      <p class="ma-0" style="font-size: 12px">기본 배송지</p>
      {{ this.$store.state.resMemberProfile.address.city }}
      {{ this.$store.state.resMemberProfile.address.street }}
      {{ this.$store.state.resMemberProfile.address.addressDetail }}
      ({{ this.$store.state.resMemberProfile.address.zipcode }})
      <button-white btn-name="배송지 변경" class="ml-5" small onclick='window.open("http://localhost:8080/modify-address", "/modify-address",
   "width=550px, height=800px")'/>
    </div>

  </div>
</template>

<script>
import {mapActions, mapState} from "vuex";

export default {
  name: "MyPageDeliverySection",
  computed : {
    ...mapState([
      'isAuthenticated',
      'resMemberProfile',
    ])
  },
  mounted() {
    if(this.$store.state.isAuthenticated === true) {
      let token = window.localStorage.getItem('userInfo')
      this.reqMemberProfileInfoToSpring(token)
    } else {
      alert("로그인 상태가 아닙니다.")
    }
  },
  methods:{
    ...mapActions([
      'reqMemberProfileInfoToSpring',
    ]),
  },
  data(){
    return{
      absolute: true,
      overlay: false,
    }
  }
}
</script>

<style scoped>

</style>