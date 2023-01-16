<template>
  <v-container>
    <div class="item-info">
      <div class="l">
        <div align="center">
          <v-img
              :src="require(`@/assets/products/uploadImg/${product.productInfo.thumbnailFileName}`)"
              max-width="640"
              max-height="480"
              contain
          />
        </div>
      </div>
      <div class="r">
        <p class="item-name">{{ product.name }}</p>
        <p class="item-description">{{ product.productInfo.subTitle }}</p>
        <v-row class="mb-3 ml-1">
          <div v-for="(tastes,index) in product.productInfo.taste" :key="index" style="color:#E53935">
          {{'#'+ tastes }}&nbsp;&nbsp;
          </div>
        </v-row>
        <div class="item-rate">
          <v-row>
            <v-rating
                :value = reviewInfo[0].average
                background-color="grey"
                color="yellow darken-1"
                half-increments
                dense>
            </v-rating>
            <p> &nbsp; {{reviewInfo[0].average}}</p>
            <p> &nbsp; / 리뷰 {{reviewInfo[0].reviewCnt}} 개</p>
          </v-row>
        </div>
        <v-divider></v-divider>
        <div class="row" style="margin: 10px 0; font-size: 18px">
          <p class="col-sm-4">제조사</p>
          <p class="col-sm-8" style="text-align: right">{{ product.brand }}</p>
        </div>
        <div class="row" style="margin: 10px 0; font-size: 18px">
          <p class="col-sm-4">판매가</p>
          <p class="col-sm-8" style="text-align: right">{{ product.price | numberFormat }} 원</p>
        </div>
        <div class="row" style="margin: 10px 0; font-size: 18px">
          <p class="col-sm-4">배송비</p>
          <p class="col-sm-8" style="text-align: right">{{ product.deliveryFee | numberFormat }} 원</p>
        </div>

        <div class="row" style="margin: 10px 0 20px; font-size: 18px">
          <p class="col-sm-5" style="text-align: left;">구매수량</p>
          <div class="col-sm-7" align="right">
            <v-btn
                class="mr-5"
                elevation="0"
                color="white"
                @click="qtyDecrease"
            >
              <v-icon>mdi-minus</v-icon>
            </v-btn>
            {{ quantity }}
            <v-btn
                class="ml-5"
                elevation="0"
                color="white"
                @click="qtyIncrease"
            >
              <v-icon>mdi-plus</v-icon>
            </v-btn>
          </div>
        </div>

        <v-divider></v-divider>
        <div class="row" style="margin-top: 60px; font-size: 25px; font-weight: bold; color: #205C37;">
          <p class="col-sm-4" style="text-align: left;">총 합계</p>
          <div class="col-sm-8" align="right">
            <p>{{ totalPrice | numberFormat }} 원</p>
          </div>
        </div>
        <div v-if="!this.$store.state.resMember.managerCheck">
          <div align="center" style="margin-top: 20px" >
            <v-btn v-if="!this.productFavoriteInfo.productFavoriteFlag" icon color="#568869" @click="btnFavorite" x-large><v-icon>mdi-heart-outline</v-icon></v-btn>
            <v-btn v-else icon color="red" @click="btnFavorite" x-large><v-icon>mdi-heart</v-icon></v-btn>
            <ButtonWhite
                @click="btnCart"
                btn-name="장바구니"
                width="240px"
                x-large
            />
            <ButtonGreen
                @click="btnDirectPurchase"
                btn-name="바로구매"
                width="240px"
                x-large
            />
          </div>
        </div>
        <div v-else>
          <div align="right" style="margin-top: 20px">
            <ButtonWhite
                @click="btnModifyProduct"
                btn-name="상품정보 수정"
                width="150px"
                x-large
            />
            <ButtonGreen
                @click="btnDeleteProduct"
                btn-name="상품정보 삭제"
                width="150px"
                x-large
            />
          </div>
        </div>

      </div>
    </div>
    <!-- 상품 상세 설명 및 리뷰 -->
    <div class="item-detail">
      <v-tabs
          fixed-tabs
          v-model="tabs"
          color="#205C37"
      >
        <v-tab v-for="list in lists" :key="list">
          {{ list }}
        </v-tab>
      </v-tabs>
      <v-divider></v-divider>
      <v-tabs-items v-model="tabs">
        <v-tab-item>
          <v-card flat height="auto">
            <v-card-title>상품 상세</v-card-title>
            <v-card-text>
              {{product.productInfo.description}}
              <div align="center" v-for="(image, index) in product.productInfo.productImagesName" :key="index">
                <v-img
                    :src="require(`@/assets/products/uploadImg/${image}`)"
                    max-width="750"
                    contain
                />
              </div>
            </v-card-text>
          </v-card>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            <v-card-text align="center">
              <product-review-form :product="product"/>
            </v-card-text>
          </v-card>
        </v-tab-item>
      </v-tabs-items>
    </div>
  </v-container>
</template>

<script>

import ProductReviewForm from "@/components/products/review/ProductReviewForm";
export default {
  name: "ProductDetailForm",
  components: {ProductReviewForm},
  data() {
    return {
      quantity: 1,
      totalPrice: 0,
      tabs: null,
      lists: [
        '상품 상세',
        '상품 리뷰',
      ],
      orderListCheck: false,
    }
  },
  props: {
    product: {
      type: Object,
      required: true,
    },
    productFavoriteInfo :{
      type: Object,
      required: true,
    },
    reviewInfo: {
      type: Array,
      required: true,
    }
  },
  methods: {
    qtyDecrease() {
      if (this.quantity > 0) {
        this.quantity--
      } else {
        this.quantity = 0
      }
    },
    qtyIncrease() {
      this.quantity++
    },
    btnCart() {
      var productNo = this.product.productNo
      const count = this.quantity
      this.$emit('addCart', {productNo, count})
    },
    async btnDirectPurchase() {
      if(this.$store.state.isAuthenticated){
        this.$store.commit('REQUEST_ORDER_LIST_FROM_SPRING', {orderSave: {directOrderCheck:true ,cartInfoCheck:false, tmpCartItemOrderNo:0,  product:this.product , quantity: this.quantity, totalPrice: this.totalPrice}})
        alert ("주문 페이지로 이동합니다.")
        this.orderListCheck = true
        if(this.orderListCheck){
          await this.$router.push({ name:'OrderInfoView'})
          this.orderListCheck=false
        }
      } else{
        alert("로그인이 필요한 기능입니다.")
      }
    },
    btnModifyProduct(){
      alert("상품수정페이지로 이동합니다.")
      this.$router.push({name: 'ProductModifyView',
        params: { productNo: this.product.productNo.toString() }})
    },
    btnDeleteProduct(){
      this.$emit('deleteProduct', this.product.productNo)
    },
    btnFavorite(){
      if(this.$store.state.isAuthenticated){
        const productNo = this.product.productNo
        this.$emit('saveFavorite', {productNo})
      } else{
        alert("로그인이 필요한 기능입니다.")
      }
    },
  },
  beforeUpdate() {
    this.totalPrice = this.product.price * this.quantity
  },
  filters: {
    // 상품 금액 천단위 콤마 찍기
    numberFormat(val) {
      return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  }
}
</script>

<style scoped>
.item-info {
  display: flex;
  justify-content: space-between;
  margin-bottom: 30px;
}

.item-info .l {
  position: relative;
  width: 45.9%;
}

.item-info .r {
  position: relative;
  width: 47.3%;
}

.item-info .r > .item-name {
  margin: 20px 0 6px;
  padding: 0;
  color: #000000;
  font-size: 36px;
  line-height: 1.2;
}

.item-info .r > .item-description {
  margin: 15px 0 30px;
  color: #656565;
  font-size: 20px;
}

.item-detail {
  margin-top: 50px;
}

.item-rate {
  margin: 20px 10px
}


</style>