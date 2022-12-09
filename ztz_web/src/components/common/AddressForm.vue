<template>
  <div>
    <v-form v-bind="$attrs" @submit.prevent="onAddressSubmit" ref="form">

      <v-row class="ml-0 mt-3">
        <div class="d-flex">
          <v-text-field v-model="zipcode" outlined dense disabled label="우편번호" required/>
        </div>
        <v-btn style="font-size: 13px; height: 40px; margin-left: 8px" @click="callDaumAddressApi" outlined dense>주소 찾기</v-btn>
      </v-row>

      <div class="d-flex">
        <v-text-field v-model="city" label="도시" outlined dense disabled required/>
      </div>

      <div class="d-flex">
        <v-text-field v-model="street" label="도로명" outlined dense disabled required/>
      </div>

      <div class="d-flex">
        <v-text-field v-model="addressDetail" label="상세주소" outlined dense required/>
      </div>

    </v-form>
  </div>
</template>

<script>
export default {
  beforeUpdate() {
    this.onAddressSubmit();
  },
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
    onAddressSubmit () {
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