<template>
  <div class="review-wrap">
    <div class="review-header">
      <div class="review-title">
        <h1> 상품 리뷰 </h1>
        <p>상품 리뷰를 확인할 수 있습니다.</p>
      </div>
      <v-row no-gutters class="mb-4">
        <v-col cols="6" class="mt-8">
          <p>총 {{ reviews.length }}개의 상품 후기가 있습니다.</p>
        </v-col>
        <v-col cols="6">
          <p style="font-size: 20px">리뷰 평점 {{ totalRate }}</p>
          <v-rating
              :value="totalRate"
              background-color="#205C37"
              color="#205C37"
              half-increments
              dense
              readonly
              x-large
          ></v-rating>
        </v-col>
      </v-row>
      <v-divider></v-divider>
    </div>
    <div class="review-container">
      <paginate tag="ul" name="reviews" :list="reviews" :per="3">
        <li v-if="!reviews || (Array.isArray(reviews) && reviews.length === 0)">
          <p class="mb-7">작성된 리뷰가 없습니다.</p>
          <v-divider width="1070px"></v-divider>
        </li>
        <li v-for="(review, idx) in paginated('reviews')" :key="idx" v-else>
          <product-review-contents
              :review="review"/>
        </li>
      </paginate>
      <paginate-links for="reviews" :simple="{
          next: 'Next »',
          prev: '« Back'
        }"></paginate-links>
    </div>
    <!-- 리뷰 등록 버튼 나중에 마이페이지 쪽으로 이동 예정(?) -->
    <div>
      <ButtonGreen
          btn-name="리뷰등록"
          @click="registerReview"
      />
      <ReviewRegisterForm
          :product="product"
          ref="ReviewRegisterForm"/>
    </div>
  </div>
</template>

<script>

import ProductReviewContents from "@/components/products/review/ProductReviewContents";
import ReviewRegisterForm from "@/components/products/review/ReviewRegisterForm";
import {mapActions, mapState} from "vuex";

export default {
  name: "ProductReviewForm",
  components: {ReviewRegisterForm, ProductReviewContents},
  data() {
    return {
      paginate: ['reviews'],
      totalRate: 0
    }
  },
  props: {
    product: {
      type: Object,
      required: true,
    }
  },
  methods: {
    ...mapActions([
      'reqReadReviewFromSpring'
    ]),
    registerReview() {
      this.$refs.ReviewRegisterForm.dialog = true
    },
  },
  created() {
    const productNo = this.product.productNo
    this.reqReadReviewFromSpring(productNo)
  },
  beforeUpdate() {
    // totalRate 구하기
    let tmpRate = 0
    for (let i = 0; i < this.reviews.length; i++) {
      tmpRate += this.reviews[i].rate
    }
    this.totalRate = parseFloat((tmpRate / this.reviews.length).toFixed(1))
  },
  computed: {
    ...mapState([
      'reviews'
    ])
  }
}
</script>

<style scoped>
* {
  list-style: none;
}

p {
  font-size: 16px;
}

.review-header {
  margin: 30px;
}

.review-title {
  padding-bottom: 18px;
}

.review-title > p {
  font-size: 16px;
  margin: 20px;
}

</style>