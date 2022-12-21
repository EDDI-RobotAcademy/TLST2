<template>
  <div align="center">
    <v-img
        class="mt-10"
        :src="require('@/assets/logo/ztz_logo1.png')" width="120" />
    <v-card class="pa-5 mb-5 mt-10" elevation="0">
      <address-form @submit="onAddressSubmit"/>
    </v-card>
    <button-green @click="modifyAddress" btn-name="배송지 저장" class="mb-10"/>
  </div>
</template>

<script>
import axios from "axios";
import {mapState} from "vuex";

export default {
  name: "ModifyAddressView",
  computed : {
    ...mapState([
      'isAuthenticated',
    ])
  },
  mounted() {
    if(this.$store.state.isAuthenticated === true) {
      this.token = window.localStorage.getItem('userInfo')
    } else {
      alert("로그인 상태가 아닙니다.")
    }
  },
  data(){
    return{
      city: '',
      street: '',
      addressDetail: '',
      zipcode: '',
      token :''
    }
  },
  methods:{
    onAddressSubmit (payload) {
      const { city, street, addressDetail, zipcode } = payload;
      this.city = city;
      this.street = street;
      this.addressDetail = addressDetail;
      this.zipcode = zipcode;

      console.log(this.city + this.street + this.addressDetail +this.zipcode)
    },
    async modifyAddress(){
      const { city, street, addressDetail, zipcode, token } = this

       await axios.post("http://localhost:7777/ztz/member/modify-address", {
        city, street, addressDetail, zipcode , token
      })
          .then((res) => {
            alert("배송지 설정이 완료 되었습니다.")
            console.log(res)
          })
          .catch((res) => {
            alert(res.response.data.message)
          })

      opener.location.reload();
      window.close()
    }
  }
}
</script>

<style scoped>

</style>