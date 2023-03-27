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
    <div class="item-info" v-if="!cartList || (Array.isArray(cartList) && cartList.length === 0)">
        <p align="center" class="mt-15 mb-15"> 장바구니 상품이 없습니다.</p>
      <v-divider></v-divider>
    </div>
    <div v-else>
    <div class="item-info" v-for="(item, index) in cartList" :key="index">
      <div class="l">
          <v-row>
             <input type="checkbox" style="accent-color: green;" name="products" :value="item" v-model="selectList" :id="item.itemNo" @change="selectItem(item.product.price, item.count)" >
              <v-img class="ml-1"
                  :src="require(`@/assets/products/uploadImg/${item.product.productInfo.thumbnailFileName}`)"
                  max-width="200"
                  max-height="150"
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
              <p>{{  item.count * item.product.price | numberFormat }} 원</p>
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

    <div class="row" style="width: 510px; margin: 50px auto 0; font-size: 20px; font-weight: bold;">
      <p style="width:200px; text-align: left; color: #555">선택한 상품 총액</p>
      <div style="width:250px; margin-left:60px ;text-align: right;  color: #555">
        <p>{{ this.totalPrice | numberFormat }} 원</p>
      </div>
    </div>
    <div class="row" style="width: 510px; margin: 5px auto; font-size: 20px; font-weight: bold;">
      <p style="width:200px; text-align: left; color: #555">배송비</p>
      <div style="width:250px; margin-left:60px;text-align: right; color: #555">
        <p v-if="this.totalPrice > 49999">0 원</p>
        <p v-else>3,000 원</p>
      </div>
    </div>
    <div class="row" style="width: 510px;  margin: 5px auto; font-size: 25px; font-weight: bold;">
      <p style="width:200px; text-align: left; color: #205c37">총 합계</p>
      <div style="width:250px; margin-left:60px ;text-align: right;  color: #205c37">
        <p v-if="this.totalPrice > 49999">{{ this.totalPrice | numberFormat }} 원</p>
        <p v-else>{{ this.totalPrice + 3000 | numberFormat }} 원</p>
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

import {mapState, mapActions} from "vuex";

export default {
  name: "CartForm",
  data() {
    return {
      totalPrice: 0,
      selectList:[],
      orderListCheck: false,
      directTotalPrice:0,
      directTmpOrderNo:[],
      directCartList: [],
      selectTotalPrice:0,
      selectCartItemNo:[]
    }
  },
  computed: {
    ...mapState([
      'cartList'
    ]),
  allSelected: {
      get: function() {
        return this.cartList.length === this.selectList.length;
      },
      set: function(e) {
        this.selectList = e ? this.cartList : [];
      }
    },
  },
  methods: {
    ...mapActions([
      'reqCartItemCountChangeToSpring'
    ]),

    selectItem(price, count){
      this.totalPrice = this.totalPrice +(price * count)
    },

    async qtyDecrease(item) {
      if (item.count> 1) {
        item.count--
      } else {
        item.count = 1
      }
      var payload =  {
        'itemNo':item.itemNo, 
        'count':item.count, 
        'selectedProductAmount': item.product.price * item.count
      }
      await this.reqCartItemCountChangeToSpring(payload);
      this.res = this.$store.state.resMyRequest;

      if (this.res === 1) {
      } else {
      }
    },
    async qtyIncrease(item) {
      item.count++
      
      var payload =  {
        'itemNo':item.itemNo, 
        'count':item.count, 
        'selectedProductAmount': item.product.price * item.count
      }
      await this.reqCartItemCountChangeToSpring(payload);
      this.res = this.$store.state.resMyRequest;

      if (this.res === 1) {
      } else {
      }
    },
    btnDeleteCartItem(){
      let deleteCartMessage = confirm("선택 상품을 삭제하시겠습니까?")

      if(deleteCartMessage){
        for (let i = 0; i < this.selectList.length; i++) {
          this.selectCartItemNo[i] = this.selectList[i].itemNo
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
      this.cartItemNo =  this.cartList[index].itemNo

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
  margin-top: 30px;
  margin-bottom: 30px;

}
.item-info .c1{
  position: relative;
  margin-top: 40px;
  margin-left: 5%;
  width: 180px;
}
.item-info .c2 {
  position: relative;
  margin-top: 50px;
  margin-left: 10%;
}

.item-info .r1 {
  position: relative;
  margin-top: 60px;
  margin-left: 10%;
  width: 90px;
}
.item-info .r2 {
  position: relative;
  margin-top: 50px;
  margin-left: 10%;
}


</style>