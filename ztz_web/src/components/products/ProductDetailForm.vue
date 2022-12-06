<template>
  <v-container>
    <div class="item-info">
      <div class="l">
        <div align="center">
          <v-img
              src="@/assets/products/item1.jpg"
              max-width="640"
              max-height="480"
              contain
          />
          <!-- v-img :src="require('../../assets/products/${이미지명}')"/ -->
        </div>
      </div>
      <div class="r">
        <p class="item-name">{{ name }}</p>
        <p class="item-description">{{ description }}</p>
        <v-divider></v-divider>
        <div class="row" style="margin: 20px 0; font-size: 18px">
          <p class="col-sm-4">판매가</p>
          <p class="col-sm-8" style="text-align: right">{{ price | numberFormat }} 원</p>
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
        <div class="row" style="margin-top: 60px; font-size: 25px; font-weight: bold">
          <p class="col-sm-4" style="text-align: left; color: #205c37">총 합계</p>
          <div class="col-sm-8" align="right" style="color: #205c37">
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
              @click="btnPurchase"
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
          color="amber darken-3"
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
          <v-card flat height="600px">
            <v-card-title>상품 리뷰</v-card-title>
            <v-card-text>상품 리뷰 입니다.</v-card-text>
          </v-card>
        </v-tab-item>
      </v-tabs-items>
      <v-divider></v-divider>
    </div>
  </v-container>
</template>

<script>

export default {
  name: "ProductDetailForm",
  data() {
    return {
      name: '붉은 원숭이',
      description: '홍국쌀로 만들어 붉은 최고급 생탁주',
      price: 20000,
      quantity: 0,
      totalPrice: 0,
      tabs: null,
      lists: [
        '상품 상세',
        '상품 리뷰',
      ]
    }
  },
  props: {
    //props로 product 정보 받아와야함.
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
      // 장바구니 버튼 클릭 -> 장바구니에 상품 추가

    },
    btnPurchase() {
      // 바로 구매 버튼 클릭 -> 구매 페이지로 이동
    }

  },
  beforeUpdate() {
    this.totalPrice = this.price * this.quantity
  },
  filters: {
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