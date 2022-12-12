<template>
  <v-container>
    <div class="item-info">
      <div class="l">
        <div align="center">
          <v-img
              :src="require(`@/assets/products/defaultImg/${product.productInfo.thumbnailFileName}`)"
              max-width="640"
              max-height="480"
              contain
          />
          <!-- v-img :src="require('../../assets/products/${이미지명}')"/ -->
        </div>
      </div>
      <div class="r">
        <p class="item-name">{{ product.name }}</p>
        <p class="item-description">{{ product.description }}</p>
        <v-divider></v-divider>
        <div class="row" style="margin: 20px 0; font-size: 18px">
          <p class="col-sm-4">판매가</p>
          <p class="col-sm-8" style="text-align: right">{{ product.price | numberFormat }} 원</p>
        </div>
        <div class="row" style="margin: 20px 0 20px; font-size: 18px">
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
        <div align="center" style="margin-top: 20px">
          <ButtonWhite
              @click="btnCart"
              btn-name="장바구니"
              width="265px"
              x-large
          />
          <ButtonGreen
              @click="btnDirectPurchase"
              btn-name="바로구매"
              width="265px"
              x-large
          />
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
          <v-card flat height="600px">
            <v-card-title>상품 상세</v-card-title>
            <v-card-text>상품 상세 입니다.</v-card-text>
          </v-card>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            <v-card-text align="center">
              <product-review-form/>
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
      const productId = this.product.productNo
      const count = this.quantity
      this.$emit('addCart', {productId, count})
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

    }

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


</style>