<template>
  <v-container>
    <div class="mb-5">
      <input type="checkbox" name="allProducts" value="all" v-model="allSelected" ><label for="all">  전체 선택</label>
    </div>
    <v-divider></v-divider>
<!--장바구니 상품 리스트-->
    <div class="item-info" v-for="(item, index) in allProductList" :key="index">
      <div class="l">
          <v-row>
             <input type="checkbox" name="products" :value="item" v-model="selectList" :id="item.id" @change="selectItem(item.price, item.quantity)" >
              <v-img
                  src="@/assets/products/img/pd_1.png"
                  max-width="320"
                  max-height="240"
                  contain
              />
            <div class="c1">
              <p class="item-name">{{ item.name }}</p>
              <p class="item-description">{{ item.company }}</p>
            </div>
            <div class="c2" >
                          <v-btn
                              class="mr-5"
                              elevation="0"
                              color="white"
                              @click="qtyDecrease(item)"
                          >
                            <v-icon>mdi-minus</v-icon>
                          </v-btn>
                          {{  item.quantity }}
                          <v-btn
                              class="ml-5"
                              elevation="0"
                              color="white"
                              @click="qtyIncrease(item)"
                          >
                            <v-icon>mdi-plus</v-icon>
                          </v-btn>
                        </div>
            <div class="r1">
              <p>{{  item.price | numberFormat }} 원</p>
            </div>
            <div class="r2">
              <ButtonWhite
                  @click="btnDirectPurchase"
                  btn-name="바로구매"
              />
            </div>
          </v-row>

          <!-- v-img :src="require('../../assets/products/${이미지명}')"/ -->
        </div>
    </div>
      <v-divider></v-divider>
<!--    장바구니 리스트 끝-->
<!--    총합계 부분-->
    <div class="row #205C37--text" style="margin-top: 60px; margin-left: 30px; font-size: 25px; font-weight: bold;">
      <p class="col-sm-4" style="text-align: right;">총 합계</p>
      <div class="col-sm-8" align="center">
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
      <ButtonAmber
          @click="btnAllPurchase"
          btn-name="전체상품 구매"
          width="265px"
          x-large
      />
    </div>

  </v-container>
</template>

<script>
export default {
  name: "CartForm",
  data() {
    return {
      totalPrice: 0,
      allProductList: [
          {id:1 , name: '화요 25', company: '(주) 화요', price: 20000, quantity: 1},
          {id:2, name: '마요 17', company: '(주) 한솥', price: 30000, quantity: 1}
      ],
      selectList:[],
    }
  },
  computed:{
    // 장바구니 전체선택 체크박스용
    allSelected: {
      //getter
      get: function() {
        return this.allProductList.length === this.selectList.length;
      },
      //setter
      set: function(e) {
        this.selectList = e ? this.allProductList : [];
      }
    },
  },
  props: {
    //props로 product 정보 받아와야함.
  },
  methods: {
    selectItem(price, quantity){
      console.log("가격과 수량: " +price +quantity)
      console.log("셀렉트 아이템 리스트: " +this.selectList)
      this.totalPrice = this.totalPrice +(price * quantity)
    },
    qtyDecrease(item) {
      if (item.quantity > 0) {
        item.quantity--
        console.log("수량 마이너스: 셀렉트 아이템 id:"+ this.selectList[item.id])
      } else {
        item.quantity = 0
      }
    },
    qtyIncrease(item) {
      item.quantity++
    },
    btnDirectPurchase(){
      //바로 구매
    },
    btnSelectPurchase() {
      // 선택상품들 구매
    },
    btnAllPurchase() {
      // 전체 상품 구매
    }
  },
  beforeUpdate() {
    this.totalPrice = 0
    for (let i = 0; i < this.selectList.length; i++) {
      this.totalPrice = this.totalPrice + this.selectList[i].price * this.selectList[i].quantity
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