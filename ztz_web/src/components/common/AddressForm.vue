<template>
  <div>
    <v-form v-bind="$attrs" @submit.prevent="onAddressSubmit" ref="form">

        <div class="d-flex">
          <v-text-field v-model="zipcode" outlined disabled label="우편번호" required color="black"/>
        <button-white
            text
            large
            class="mt-0 ml-5 mr-0"
            btn-name="주소 찾기"
            style="font-size: 13px; height: 55px;"
            @click="callDaumAddressApi" outlined>
        </button-white>
        </div>

      <div class="d-flex">
        <v-text-field v-model="city" label="도시" outlined disabled required color="black"/>
      </div>

      <div class="d-flex">
        <v-text-field v-model="street" label="도로명" outlined disabled required color="black"/>
      </div>

      <div class="d-flex">
        <v-text-field v-model="addressDetail" label="상세주소" outlined required color="black"/>
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
  data() {
    return {
      city: '',
      street: '',
      addressDetail: '',
      zipcode: '',
      streetPass: false,
    }
  },
  props: {},
  methods: {
    onAddressSubmit() {
      const {city, street, addressDetail, zipcode} = this
      this.$emit("submit", {city, street, addressDetail, zipcode})
    },
    callDaumAddressApi() {
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