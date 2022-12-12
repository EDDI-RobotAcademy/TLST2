<template>
  <div class="white" style="font-family: Arial">
    <h2>결제하기</h2>
    <v-col style="margin-top: 20px">
      <p style="width: 800px; margin-bottom: 15px;border-top: 2px solid black"></p>

      <v-btn @click="orderMemberInfoVisible" plain>
        주문정보 확인하기
        <p style="width: 600px"></p>
        <v-icon v-if="ShowDirection">mdi-chevron-down</v-icon>
        <v-icon v-else>mdi-chevron-up</v-icon>
      </v-btn>

      <div v-if="MemberInfoShow" style="margin-top: 50px; margin-left: 25px">
        <template>
          <v-row justify="left" >
            <p style="padding-top: 9px; width: 150px; font-size: 13px">이름</p>
            <p style="width: 600px">
              <v-text-field outlined dense="true" style="font-size: 13px"></v-text-field>
            </p>
          </v-row>

          <v-row justify="left" >
            <p style="padding-top: 9px; width: 150px; font-size: 13px">이메일</p>
            <p style="width: 250px">
              <v-text-field outlined dense="true" style="font-size: 13px"></v-text-field>
            </p>
            <p style="margin: 5px">@</p>
            <p style="width: 330px;">
              <v-select :items="PortalSites" outlined dense="true" style="font-size: 13px;"></v-select>
            </p>
          </v-row>

          <v-row justify="left" >
            <p style="padding-top: 9px; width: 150px; font-size: 13px">전화번호</p>
            <p style="width: 250px">
              <v-select :items="LocalNumber" outlined dense="true" style="font-size: 13px;"></v-select>
            </p>
            <p style="margin: 9px">-</p>
            <p style="width: 330px;">
            <v-text-field label=" '-'없이 휴대폰 번호 입력" outlined dense="true" style="font-size: 13px;"></v-text-field>
            </p>
          </v-row>
        </template>
      </div>

      <p style="width: 800px; margin-bottom: 15px;border-top: 2px solid black"></p>
      <v-row>
        <p style="margin-top: 20px; margin-left: 30px">배송지 정보</p>
        <v-btn style="margin-top: 20px; margin-left: 530px" small>주문 고객과 동일</v-btn>
      </v-row>

      <div style="margin-top: 50px; margin-left: 25px">
        <v-row justify="left" >
          <p style="padding-top: 9px; width: 150px; font-size: 13px">받는분</p>
          <p style="width: 600px">
            <v-text-field outlined dense="true" style="font-size: 13px"></v-text-field>
          </p>
        </v-row>

        <v-row justify="left" >
          <p style="padding-top: 9px; width: 150px; font-size: 13px">전화번호</p>
          <p style="width: 250px">
            <v-select :items="LocalNumber" outlined dense="true" style="font-size: 13px;"></v-select>
          </p>
          <p style="margin: 9px">-</p>
          <p style="width: 330px;">
            <v-text-field label=" '-'없이 휴대폰 번호 입력" outlined dense="true" style="font-size: 13px;"></v-text-field>
          </p>
        </v-row>

          <v-row justify="left">
            <p style="padding-top: 9px; width: 150px; font-size: 13px">주소</p>
            <div class="d-flex">
              <v-text-field v-model="zipcode" outlined dense disabled style="font-size: 13px;" required/>
            </div>
            <v-btn style="font-size: 13px; height: 40px; margin-left: 8px" @click="callDaumAddressApi" outlined dense>우편번호 찾기</v-btn>
          </v-row>

        <div class="d-flex" style="margin-left: 138px; width: 600px">
          <v-text-field v-model="city" outlined dense disabled style="font-size: 13px;" required/>
        </div>

        <div class="d-flex" style="margin-left: 138px; width: 600px">
          <v-text-field v-model="street" outlined dense disabled style="font-size: 13px;" required/>
        </div>

        <div class="d-flex" style="margin-left: 138px; width: 600px">
          <v-text-field v-model="addressDetail" outlined dense style="font-size: 13px;" required/>
        </div>

      </div>
    </v-col>
    <v-card outlined width="775px" style="margin-bottom: 30px">
      <p style="padding: 20px">
        배송요청사항
      </p>
      <v-select :items="RequestItems" v-model="Request" outlined dense="true" style="font-size: 13px; margin: 30px">

      </v-select>
    </v-card>

<!--    주문상품-->
    <p style="width: 800px; margin-bottom: 15px;border-top: 2px solid black"></p>
    <v-row>
      <p style="margin: 20px"> 주문 상품 </p>

      <p style="margin: 20px; margin-left: 620px; font-size: 13px" >총 {{totalCount}}건</p>
    </v-row>

<!--    바로 구매 (단건)인 경우 : directOrderCheck는 true  -->
    <!--    데이터 분석 orderList = (orderSave( cartInfoCheck:false, directOrderCheck:true , tmpCartItemOrderNo:0,  quantity, totalPrice, product(productNo, brand, name, price, productInfo(thumnailFileName) ) )-->
    <v-list v-if="this.orderList.orderSave.directOrderCheck">
      <v-list-item>
        <v-card style="width: 760px">
          <v-list-item-content >
            <v-row justify="left" v-for="item in orderList" :key="item.tmpCartItemOrderNo">
              <v-img :src="require(`@/assets/products/defaultImg/${item.product.productInfo.thumbnailFileName}`)"
                     max-width="60"
                     style="margin: 15px; margin-left: 25px;"/>
              <p style="margin-left: 50px; margin-top: 33px">{{ item.product.name}}</p>
              <p style="margin-left: 400px;  margin-top: 33px; font-weight: bold">{{item.product.price}}원</p>
              <p style="margin-top: 33px;">/ {{item.quantity}}개</p>
            </v-row>
          </v-list-item-content>
        </v-card>
      </v-list-item>
    </v-list>

<!--    총 합계 추가 -->
    <div class="row" style="margin-top: 60px; margin-left: 30px; font-size: 25px; font-weight: bold;">
      <p class="col-sm-4" style="text-align: right; color: #205c37">총 합계</p>
      <div class="col-sm-8" align="center" style=" color: #205c37">
        <p>{{ this.totalPrice | numberFormat }} 원</p>
      </div>
    </div>

    <p style="padding-left: 270px"><ButtonGreen
        @click="payBtn"
        btn-name="결제하기"
        width="265px"
        x-large
    /></p>
    </div>
</template>

<script>

import {mapState} from "vuex";

export default {
  name: "OrderInfoForm",
  data() {
    return{
      Request:'',

      MemberInfoShow : true,
      ShowDirection : true,
      PortalSites :['naver.com', 'gmail.com',],
      LocalNumber :['010','011','016','017','018','019'],
      RequestItems:['조심히 안전하게 와주세요~','배송전 미리 연락주세요!','경비실에 맡겨주세요!','조심!또 조심!'],

      city: '',
      street: '',
      addressDetail: '',
      zipcode: '',

      //추가
      totalPrice: 0,
      totalCount: 0,

    }
  },
  computed:{
    ...mapState([
        'orderList'
    ])
  },
 created() {

    this.totalPrice =this.$store.state.orderList.orderSave.totalPrice
   if(this.orderList.orderSave.directOrderCheck){ //바로 구매일 경우
     this.totalCount = 1
   }
  },
  methods : {
    orderMemberInfoVisible(){
      this.MemberInfoShow = !this.MemberInfoShow;

      if(this.MemberInfoShow == true){
        this.ShowDirection = true;
      }else {
        this.ShowDirection = false;
      }
    },
    payBtn(){

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
          this.streetPass = true
        }
      }).open()
    },
  },
  filters: {
    numberFormat(val) {
      return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  },
}
</script>

<style scoped>

</style>