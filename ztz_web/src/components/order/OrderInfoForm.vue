<template>
  <div class="white" style="font-family: Arial" @submit.prevent="payment" ref="form">
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

      <v-card v-else class="pt-5 pl-5" outlined>
        <address-form @submit="onAddressSubmit"/>
      </v-card>

      <order-product-info @submit="onProductInfoSubmit"/>

      <order-agreement class="mb-5" :TotalPaymentAmount= "paymentPrice" />

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
      'resMemberProfile',
      'orderList'
    ]),
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
      paymentPrice: 0,
      totalCount: 0,

      //결제 후 장바구니 아이템 삭제용
      orderCartItemNo:[],

      setDestination: true,
      setAddress: false,

      uid_num: 0o00321,
      merchant_uid :'ORD2022-',
      randomNumber : 0,
      usedNum :[],

      sendInfo :{
        productID : [],
        memberID : [],
        orderCnt : []
      }
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
      'reqMemberProfileInfoToSpring',
      'reqDeleteCartItemFromSpring'
    ]),
    setSendInfo(){
      if(this.orderList.orderSave.directOrderCheck){
        this.$set(this.sendInfo.productID, 0, this.$store.state.orderList.orderSave.product.productNo);
        this.$set(this.sendInfo.memberID, 0, this.$store.state.resMember.id);
        this.$set(this.sendInfo.orderCnt, 0, this.$store.state.orderList.orderSave.quantity);
      }else {
        for (let i = 0; i < this.totalCount; i++) {
          this.$set(this.sendInfo.productID, i, this.$store.state.orderList.orderSave.selectList[i].product.productNo);
          this.$set(this.sendInfo.memberID, i, this.$store.state.resMember.id);
          this.$set(this.sendInfo.orderCnt, i, this.$store.state.orderList.orderSave.selectList[i].count);

          this.orderCartItemNo[i] = this.$store.state.orderList.orderSave.selectList[i].cartItemNo
        }
      }
    },
    delSelectedOrderCart(){
      this.reqDeleteCartItemFromSpring(this.orderCartItemNo)
    },
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
      this.setDestination = !this.setDestination;
    },
    onAddressSubmit (payload) {
      const { city, street, addressDetail, zipcode } = payload;
      this.city = city;
      this.street = street;
      this.addressDetail = addressDetail;
      this.zipcode = zipcode;

      console.log(this.city + this.street + this.addressDetail +this.zipcode)
    },
    onProductInfoSubmit (payload) {
      const { totalCount, totalPrice } = payload;
      this.totalCount = totalCount;
      this.paymentPrice = totalPrice;
    },
    payment() {
      console.log("paymentBtn - 실행")

      this.randomNumber = Math.floor(Math.random()*100000);

      for (let i = 0; i < this.usedNum.length; i++) {
        if(this.usedNum[i] == this.randomNumber){
          console.log(this.usedNum[i])
          continue;
        }
      }
      IMP.request_pay({ // param
        pg: "html5_inicis",
        pay_method: "card",
        merchant_uid: this.merchant_uid + this.randomNumber,
        name: "ZTZ 전통주 결제",
        amount: 100 /*this.totalPrice*/,
        buyer_email: this.$store.state.resMember.email,
        buyer_name: this.$store.state.resMember.username,
        buyer_tel: this.$store.state.resMemberProfile.phoneNumber,
        buyer_addr: this.city + this.street + this.addressDetail ,
        buyer_postcode: this.zipcode
      }, rsp => { // callback
        if (rsp.success) {
          let imp_uid = rsp.imp_uid
          this.merchant_uid += this.randomNumber
          console.log("결제성공")
          this.usedNum.push(this.randomNumber)

          this.setSendInfo()

          const { paymentPrice, merchant_uid , sendInfo,city, street, addressDetail, zipcode ,sendRequest} = this
          this.$emit("submit", { paymentPrice , merchant_uid , sendInfo, imp_uid,city, street, addressDetail, zipcode,sendRequest })

          this.delSelectedOrderCart()
        } else {
          console.log("결제실패")
        }
      });
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
  filters: {
    numberFormat(val) {
      return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
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