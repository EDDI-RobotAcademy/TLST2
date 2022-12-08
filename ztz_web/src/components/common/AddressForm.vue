<template>
  <div>
    <v-form @submit.prevent="onSubmit" ref="form">

    <v-row justify="left">
        <p style="padding-top: 9px; width: 150px; font-size: 13px">주소</p>
        <div class="d-flex">
          <v-text-field v-model="zipcode"  outlined dense disabled style="font-size: 13px;" required/>
        </div>
        <v-btn style="font-size: 13px; height: 40px; margin-left: 8px" @click="callDaumAddressApi" outlined dense>우편번호 찾기</v-btn>
        <v-btn style="font-size: 13px; height: 40px; margin-left: 8px" type="submit" outlined dense>현재 주소 저장</v-btn>
      </v-row>

      <div class="d-flex" style="margin-left: 138px; width: 600px">
        <v-text-field v-model="city"  outlined dense disabled style="font-size: 13px;" required/>
      </div>

      <div class="d-flex" style="margin-left: 138px; width: 600px">
        <v-text-field v-model="street"  outlined dense disabled style="font-size: 13px;" required/>
      </div>

      <div class="d-flex" style="margin-left: 138px; width: 600px">
        <v-text-field v-model="addressDetail"  outlined dense style="font-size: 13px;" required/>
      </div>

    </v-form>
  </div>
</template>

<script>
export default {
  name: "AddressForm",
  data () {
    return{
      city: '',
      street: '',
      addressDetail: '',
      zipcode: '',
      streetPass: false,
    }
  },
  props:{

  },
  methods:{
    onSubmit () {
        const { city, street, addressDetail, zipcode } = this
        this.$emit("submit", { city, street, addressDetail, zipcode })
    },
    callDaumAddressApi () {
      new window.daum.Postcode({
        oncomplete: (data) => {
          let fullRoadAddr = data.roadAddress;
          let extraRoadAddr = '';
          if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
            extraRoadAddr += data.bname;
          }
          if (data.buildingName !== '' && data.apartment === 'Y') {
            extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
          }
          if (extraRoadAddr !== '') {
            extraRoadAddr = ' (' + extraRoadAddr + ')';
          }
          if (fullRoadAddr !== '') {
            fullRoadAddr += extraRoadAddr;
          }
          this.city = data.sido;
          this.zipcode = data.zonecode;
          this.street = data.sigungu + ' ' + fullRoadAddr;
        }
      }).open()
    },
  }
}
</script>

<style scoped>

</style>