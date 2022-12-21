<template>
  <v-container>
    <div class="mb-5">
      <v-row>
      <input type="checkbox" style="accent-color: green;" name="allProducts" value="all" v-model="allSelected" class="mb-3" ><label for="all">&nbsp;&nbsp;&nbsp;전체 선택</label>
      <v-spacer></v-spacer>
        <v-btn text @click="btnDeleteCartItem"><v-icon>mdi-delete-outline</v-icon>선택 삭제</v-btn>
      </v-row>
    </div>
    <v-divider></v-divider>
<!--장바구니 상품 리스트-->
    <div class="item-info" v-if="!cartList || (Array.isArray(cartList) && cartList.length === 0)">
        <p align="center" class="mt-15 mb-15"> 장바구니 상품이 없습니다.</p>
      <v-divider></v-divider>
    </div>
    <div v-else>
    <div class="item-info" v-for="(item, index) in cartList" :key="index">
      <div class="l">
          <v-row>
             <input type="checkbox" style="accent-color: green;" name="products" :value="item" v-model="selectList" :id="item.id" @change="selectItem(item.product.price, item.count)" >
              <v-img
                  :src="require(`@/assets/products/uploadImg/${item.product.productInfo.thumbnailFileName}`)"
                  max-width="320"
                  max-height="240"
                  contain
              />
            <div class="c1">
              <p class="item-name" @click="productViewBtn(item)">{{ item.product.name }}</p>
              <p class="item-description" @click="productViewBtn(item)">{{ item.product.brand }}</p>
            </div>
            <div class="c2" >
                          <v-btn
                              class="mr-3"
                              elevation="0"
                              color="white"
                              @click="qtyDecrease(item)"
                          >
                            <v-icon>mdi-minus</v-icon>
                          </v-btn>
                          {{  item.count }}
                          <v-btn
                              class="ml-3"
                              elevation="0"
                              color="white"
                              @click="qtyIncrease(item)"
                          >
                            <v-icon>mdi-plus</v-icon>
                          </v-btn>
                        </div>
            <div class="r1">
              <p>{{  item.product.price | numberFormat }} 원</p>
            </div>
            <div class="r2">
              <ButtonWhite class="ml-0"
                  @click="btnDirectPurchase(item, index)"
                  btn-name="바로구매"
              />
            </div>
          </v-row>

        </div>
      <v-divider></v-divider>
    </div>
    </div>
<!--    장바구니 리스트 끝-->
<!--    총합계 부분-->
    <div class="row" style="margin-top: 60px; margin-left: 30px; font-size: 25px; font-weight: bold;">
      <p class="col-sm-4" style="text-align: right; color: #205c37">총 합계</p>
      <div class="col-sm-8" align="center" style=" color: #205c37">
        <p>{{ this.totalPrice | numberFormat }} 원</p>
      </div>
    </div>
    <div align="center" style="margin-top: 20px">
      <ButtonWhite
          @click="btnSelectPurchase"
          btn-name="선택상품 구매"
          width="265px"
          x-large
      />
      <ButtonGreen
          @click="btnAllPurchase"
          btn-name="전체상품 구매"
          width="265px"
          x-large
      />
    </div>

  </v-container>
</template>

<script>

import {mapState} from "vuex";

export default {
  name: "CartForm",
  data() {
    return {
      totalPrice: 0,
      selectList:[],

      //async용
      orderListCheck: false,

      //바로 구매
      directTotalPrice:0,
      directTmpOrderNo:[],
      directCartList: [],

      //주문페이지 전달용
      selectTotalPrice:0,

      //카트아이템 삭제용
      selectCartItemNo:[]
    }
  },
  computed: {
    ...mapState([
      'cartList'
    ]),
  allSelected: {
      //getter
      get: function() {
        return this.cartList.length === this.selectList.length;
      },
      //setter
      set: function(e) {
        this.selectList = e ? this.cartList : [];
      }
    },
  },
  methods: {
    selectItem(price, count){
      console.log("가격과 수량: " +price +count)
      console.log("셀렉트 아이템 리스트: " +this.selectList)
      this.totalPrice = this.totalPrice +(price * count)
    },
    qtyDecrease(item) {
      if (item.count> 0) {
        item.count--
      } else {
        item.count = 0
      }
    },
    qtyIncrease(item) {
      item.count++
    },
    btnDeleteCartItem(){
      let deleteCartMessage = confirm("선택 상품을 삭제하시겠습니까?")

      if(deleteCartMessage){
        for (let i = 0; i < this.selectList.length; i++) {
          this.selectCartItemNo[i] = this.selectList[i].cartItemNo
        }
        this.$emit('deleteCartItem', this.selectCartItemNo)
      }

    },

    async btnDirectPurchase(item, index){

      this.directTotalPrice = item.count * item.product.price

      this.directTmpOrderNo= index
      this.directCartList = this.cartList[index]
      this.quantity = this.cartList[index].count
      this.cartNo = this.cartList[index].cart.cartNo
      this.cartItemNo =  this.cartList[index].cartItemNo

      this.$store.commit('REQUEST_ORDER_LIST_FROM_SPRING',
          {orderSave: {directOrderCheck:true ,cartInfoCheck:true, tmpCartItemOrderNo: this.cartItemNo, cartNo: this.cartNo,
                              product:this.directCartList.product , quantity: this.quantity, totalPrice: this.directTotalPrice}})

      alert ("주문 페이지로 이동합니다.")
      this.orderListCheck = true
      if(this.orderListCheck) {
        await this.$router.push({name: 'OrderInfoView'})
        this.orderListCheck = false
      }
    },
    async btnSelectPurchase() {
      //선택 상품 구매
      for (let i = 0; i < this.selectList.length; i++) {
        this.selectTotalPrice = this.selectTotalPrice + (this.selectList[i].product.price * this.selectList[i].count)
      }

      this.$store.commit('REQUEST_ORDER_LIST_FROM_SPRING',
          {orderSave: {directOrderCheck:false, cartOrderCheck:true, selectList: this.selectList, totalPrice: this.selectTotalPrice }})

      alert ("주문 페이지로 이동합니다.")
      this.orderListCheck = true
      if(this.orderListCheck) {
        await this.$router.push({name: 'OrderInfoView'})
        this.orderListCheck = false
      }
    },
    async btnAllPurchase() {
      // 전체 상품 구매
      this.selectList = this.cartList
      for (let i = 0; i < this.selectList.length; i++) {
        this.selectTotalPrice = this.selectTotalPrice + (this.selectList[i].product.price * this.selectList[i].count)
      }

      this.$store.commit('REQUEST_ORDER_LIST_FROM_SPRING',
          {orderSave: {directOrderCheck:false, cartOrderCheck:true, selectList: this.selectList, totalPrice: this.selectTotalPrice }})

      alert ("주문 페이지로 이동합니다.")
      this.orderListCheck = true
      if(this.orderListCheck) {
        await this.$router.push({name: 'OrderInfoView'})
        this.orderListCheck = false
        }
    },
    productViewBtn(item){
      alert("상품 상세페이지로 이동합니다.")
      this.$router.push({name: 'ProductDetailView', params: {productNo: item.product.productNo}})
    }
  },
  beforeUpdate() {
    this.totalPrice = 0
    for (let i = 0; i < this.selectList.length; i++) {
      this.totalPrice = this.totalPrice + this.selectList[i].product.price * this.selectList[i].count
    }
  },
  //가격 ,000 원단위 포맷으로 가공
  filters: {
    numberFormat(val) {
      return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  },
}
</script>

<style scoped>

.item-info .l {
  position: relative;
  margin-top: 10px;
}
.item-info .c1{
  position: relative;
  margin-top: 70px;
  margin-left: 5%;
}
.item-info .c2 {
  position: relative;
  margin-top: 100px;
  margin-left: 15%;
}

.item-info .r1 {
  position: relative;
  margin-top: 105px;
  margin-left: 10%;
}
.item-info .r2 {
  position: relative;
  margin-top: 90px;
  margin-left: 5%;
}


</style>