<template>
  <div class="white" style="font-family: Arial" @submit.prevent="payment" ref="form">
    <v-container style="width: 75%; margin-left: 22px">
      <div class="fly">
        <p style="font-weight: bold; font-size: 17px">
          결제정보
        </p>
        <v-card class="pt-3 pl-3 pb-3" style="background-color: #F2F2F2; font-size: 15px" outlined>
          <span>상품금액<span style="text-align:right;display: inline-block; width: 150px">{{ paymentPrice | numberFormat}}원</span></span><br>
          <span class="ml-3 mt-3" style="display: inline-block; font-size: 12px; color: #A4A4A4">⨽ 상품금액 <span style="text-align:right;display: inline-block; width: 134px">{{ nonDiscountPrice | numberFormat}}원</span></span><br>
          <span class="ml-3" style="font-size: 12px; color: #A4A4A4">⨽ 할인금액 <span style="text-align:right;display: inline-block; width: 134px">{{ nonDiscountPrice - paymentPrice | numberFormat}}원</span></span><br>
          <span class="pt-3 pb-3" style="display: inline-block;">배송비
            <span v-if="this.paymentPrice >= 50000" style="text-align:right;display: inline-block; width: 160px">0원</span>
            <span v-else style="text-align:right;display: inline-block; width: 160px">{{ 3000 | numberFormat}}원</span>
          </span><br>
          <v-divider/>
          <span class="pt-3" style="display: inline-block;">총 결제금액
            <span v-if="this.paymentPrice >= 50000" style="text-align:right;display: inline-block; width: 126px">{{ paymentPrice | numberFormat}}원</span>
            <span v-else style="text-align:right;display: inline-block; width: 126px">{{ paymentPrice + 3000 | numberFormat}}원</span></span>
        </v-card>
      </div>

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
        <p style="font-size: 15px; padding-top: 15px ; padding-bottom: 5px; padding-left: 10px">
          {{ this.$store.state.resMemberProfile.address.street }}
          {{ this.$store.state.resMemberProfile.address.addressDetail }}
          ({{ this.$store.state.resMemberProfile.address.zipcode }})
        </p>
      </v-card>

      <v-card v-else class="pl-5 pr-5" outlined style="padding-top: 20px;">
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
IMP.init("imp67851243");
//imp20030584

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
      nonDiscountPrice : 0,
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
        orderCnt : [],
        orderPrice: []
      }
    }
  },
  mounted() {
    if(this.$store.state.isAuthenticated === true) {
      let token = window.localStorage.getItem('userInfo')
      this.reqMemberInfoToSpring(token)
      this.reqMemberProfileInfoToSpring(token)
    }
    if(this.orderList.orderSave.directOrderCheck){
      if(this.orderList.orderSave.product.monthAlcoholCheck){
        for (let i = 0; i < this.orderList.orderSave.quantity; i++) {
          this.nonDiscountPrice += this.orderList.orderSave.product.price / 0.9
        }
      }else {
        for (let i = 0; i < this.orderList.orderSave.quantity; i++) {
          this.nonDiscountPrice += this.orderList.orderSave.product.price
        }
      }
    }else {
      for (let i = 0; i < this.orderList.orderSave.selectList.length; i++) {
        if(this.orderList.orderSave.selectList[i].product.monthAlcoholCheck){
          for (let j = 0; j < this.orderList.orderSave.selectList[i].count ; j++) {
            this.nonDiscountPrice += this.orderList.orderSave.selectList[i].product.price / 0.9;
          }
        }else {
          for (let j = 0; j < this.orderList.orderSave.selectList[i].count ; j++) {
            this.nonDiscountPrice += this.orderList.orderSave.selectList[i].product.price
          }
        }
      }
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
        this.$set(this.sendInfo.orderPrice, 0, (this.$store.state.orderList.orderSave.product.price * this.$store.state.orderList.orderSave.quantity));
      }else {
        for (let i = 0; i < this.totalCount; i++) {
          this.$set(this.sendInfo.productID, i, this.$store.state.orderList.orderSave.selectList[i].product.productNo);
          this.$set(this.sendInfo.memberID, i, this.$store.state.resMember.id);
          this.$set(this.sendInfo.orderCnt, i, this.$store.state.orderList.orderSave.selectList[i].count);
          this.$set(this.sendInfo.orderPrice, i, (this.$store.state.orderList.orderSave.selectList[i].product.price * this.$store.state.orderList.orderSave.selectList[i].count));

          this.orderCartItemNo[i] = this.$store.state.orderList.orderSave.selectList[i].itemNo
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
      if(this.street == ''){
        alert("주소지 설정을 진행 해주세요")
      }else if(this.selectedRequest == ''){
        alert("배송 요청사항을 입력해주세요")
      }else {
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
          amount: 100 /*this.paymentPrice*/,
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
  beforeUnmount() {
    // I switched the example from `destroyed` to `beforeDestroy`
    // to exercise your mind a bit. This lifecycle method works too.
    this.target.removeEventListener('scroll', this.handleScroll);
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
  font-size: 14px;
  font-weight: bold;
  width: 170px;
  margin-right: 0px;
  padding-right: 0px;
}
.member-info-card .member-row .member-info{
  font-size: 14px;
}
.member-info-card .member-row .member-request-select{
  padding: 0px !important;
  max-width: 500px;
  font-size: 14px;
  min-height: 20px !important;
}
.fly {
  margin-top: 200px;
  position:fixed;
  left:50%;
  width:250px;
  top:100px;
  height:210px;
  margin-left:320px;
}
</style>