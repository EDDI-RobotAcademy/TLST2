<template>
  <div class="white" style="font-family: Arial">
    <v-container>
      <h3>주문/결제 하기</h3>
      <v-divider class="mt-3 mb-3"/>
      <p align="left">수령자 정보</p>

      <v-card class="member-info-card" outlined>

        <v-row class="member-row" >
          <p class="member-tool" align="left">수령인</p>
          <p class="member-info">{{ this.$store.state.resMember.username }}</p>
        </v-row>
        <v-divider class="mt-1 mb-3"/>

        <v-row class="member-row" >
          <p class="member-tool" align="left">전화번호</p>
          <p class="member-info">{{ this.$store.state.resMemberProfile.phoneNumber }}</p>
        </v-row>
        <v-divider class="mt-1 mb-3"/>

        <v-row class="member-row" >
          <p class="member-tool" align="left">배송지</p>
          <p class="member-info">
            {{ this.$store.state.resMemberProfile.address.city }}
            {{ this.$store.state.resMemberProfile.address.street }}
            {{ this.$store.state.resMemberProfile.address.addressDetail }}
            ({{ this.$store.state.resMemberProfile.address.zipcode }}) |
            <V-btn @click="setDestinationToAddress" v-if="setDestination" style="height: 17px; font-size: 12px" outlined>주소지를 배송지로</V-btn>
            <V-btn @click="setDestinationToAddress" v-else style="height: 17px; font-size: 12px" outlined>배송지 입력하기</V-btn>
          </p>
        </v-row>
        <v-divider class="mt-1 mb-3"/>

        <v-row class="member-row">
          <p class="member-tool mt-3" align="left">배송시 요청 사항</p>
          <v-select  v-bind:items="request" v-model="selectedRequest" class="member-request-select" dense outlined/>
        </v-row>

        <v-text-field v-if="directlyInput" class="member-request-direct" v-model="directRequest" outlined dense/>
      </v-card>

      <v-divider class="mt-3 mb-3"/>
      <p align="left">
        배송지 정보
      </p>

      <v-card v-if="setAddress" outlined style="padding: 5px">
        <p style="font-size: 12px; padding: 2px">
          {{ this.$store.state.resMemberProfile.address.city }}
          {{ this.$store.state.resMemberProfile.address.street }}
          {{ this.$store.state.resMemberProfile.address.addressDetail }}
          ({{ this.$store.state.resMemberProfile.address.zipcode }})
        </p>
      </v-card>

      <v-card v-else class="pt-5 pl-5">
        <address-form @submit="onAddressSubmit"/>
      </v-card>

      <order-product-info/>

      <order-agreement class="mb-5" TotalPaymentAmount="20000"/>

    </v-container>

    <p align="center">
      <ButtonGreen @click="payment" btn-name="결제하기" width="265px" x-large/>
    </p>
  </div>
</template>

<script>
import OrderAgreement from "@/components/order/OrderAgreement";
const IMP = window.IMP;
IMP.init("imp20030584");

import {mapActions, mapState} from "vuex";

import AddressForm from "@/components/common/AddressForm";
import OrderProductInfo from "@/components/order/OrderProductInfo";
export default {
  name: "OrderInfoForm",
  components: {OrderProductInfo, OrderAgreement, AddressForm},
  computed : {
    ...mapState([
      'isAuthenticated',
      'resMember',
      'resMemberProfile'
    ]),
    ...mapState([
      'orderList'
    ])
  },
  data() {
    return{
      directlyInput:false,
      request:['문앞에 두고 가주세요' , '조심히 안전하게 와주세요', '출발전 문자 부탁드립니다','부재시 경비실에 맡겨주세요', '직접입력'],
      selectedRequest:'',
      directRequest:'',
      sendRequest:'',

      city: '',
      street: '',
      addressDetail: '',
      zipcode: '',

      //추가
      totalPrice: 0,
      totalCount: 0,

      //결제 후 장바구니 아이템 삭제용
      orderCartItemNo:[],

      setDestination: true,
      setAddress: false,

      PaymentPrice: 100,
      uid_num: 0o00321,
      merchant_uid :'ORD20221207-',
      randomNumber : 0,
      usedNum :[],

    }
  },
  mounted() {
    if(this.$store.state.isAuthenticated === true) {
      let token = window.localStorage.getItem('userInfo')
      this.reqMemberInfoToSpring(token)
      this.reqMemberProfileInfoToSpring(token)
    } else {
      alert("로그인 상태가 아닙니다.")
    }
  },
  methods : {
    ...mapActions([
      'reqMemberInfoToSpring',
      'reqMemberProfileInfoToSpring'
    ]),
    setDestinationToAddress(){
      if(this.setAddress == false ){
        this.city = this.$store.state.resMemberProfile.address.city
        this.street = this.$store.state.resMemberProfile.address.street
        this.addressDetail = this.$store.state.resMemberProfile.address.addressDetail
        this.zipcode = this.$store.state.resMemberProfile.address.zipcode

        alert("기본 주소를 배송지로 설정하였습니다.")
        console.log(this.city + this.street + this.addressDetail +this.zipcode)
      }
      this.setAddress = !this.setAddress;
    },
    onAddressSubmit (payload) {
      const { city, street, addressDetail, zipcode } = payload;
      this.city = city;
      this.street = street;
      this.addressDetail = addressDetail;
      this.zipcode = zipcode;

      console.log(this.city + this.street + this.addressDetail +this.zipcode)
    },
    payment() {

    }
  },
  beforeUpdate() {
    if( this.selectedRequest == this.request[4]){
      this.directlyInput =true;
      this.sendRequest= this.directRequest;
    }else {
      this.directlyInput =false;
      this.sendRequest = this.selectedRequest;
    }
  },
}
</script>

<style scoped>
.member-info-card .member-row {
  margin-top: 10px;
  margin-left: 20px;
}
.member-info-card .member-request-direct {
  margin-right: 20px;
  margin-left: 190px;
}
.member-info-card .member-row .member-tool{
  font-size: 12px;
  font-weight: bold;
  width: 170px;
  margin-right: 0px;
  padding-right: 0px;
}
.member-info-card .member-row .member-info{
  font-size: 12px;
}
.member-info-card .member-row .member-request-select{
  padding: 0px !important;
  max-width: 500px;
  font-size: 12px;
  min-height: 20px !important;
}
</style>