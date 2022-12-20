<template>
  <div class="reviewCard">
    <v-card outlined>
      <div class="mt-4 ml-4">
        <v-row>
          <v-col cols="2">
            <router-link
                :to="{ name: 'ProductDetailView',
                          params: { productNo: review.product.productNo.toString()}}">
              <v-img
                  style="margin: auto"
                  :src="require(`../../assets/products/uploadImg/${review.product.productInfo.thumbnailFileName}`)"
                  max-height="50px"
                  max-width="50px"
                  contain/>
            </router-link>
          </v-col>
          <v-col>
            <p style="font-size: 14px">주문 번호 : </p>
            <p style="font-size: 14px">상품명 : {{ review.product.name }}</p>
          </v-col>
        </v-row>
      </div>
      <v-divider></v-divider>
      <v-row class="ma-1">
        <v-col>
          <div class="product">
            <v-img
                v-if="!(review.thumbnailFileName == null)"
                style="margin: auto"
                :src="require(`../../assets/products/uploadImg/${review.thumbnailFileName}`)"
                max-height="150px"
                max-width="200px"
                contain/>
            <div class="noImage" v-else>
              No Image
            </div>
          </div>
        </v-col>
        <v-col>
          <v-card-text>
            <p>{{ review.regDate }}</p>
            <v-rating
                :value="review.rate"
                background-color="#205C37"
                color="#205C37"
                readonly
                dense/>
          </v-card-text>
          <v-card-text>
            <p>{{ review.content }}</p>
          </v-card-text>
        </v-col>
      </v-row>
      <v-row no-gutters dense>
        <v-col class="mr-3 mb-2" align="right">
          <button-white
              small
              @click="btnModifyReview"
              btn-name="수정"/>
          <button-white
              small
              @click="btnDeleteReview"
              btn-name="삭제"/>
        </v-col>
      </v-row>
    </v-card>
    <review-modify-form
        ref="ReviewModifyForm"
        :review="review"/>
  </div>
</template>

<script>
import {mapActions} from "vuex";
import ReviewModifyForm from "@/components/products/review/ReviewModifyForm";

export default {
  name: "MyPageReviewCard",
  components: {ReviewModifyForm},
  props: {
    review: Object,
  },
  methods: {
    ...mapActions([
       'reqDeleteReviewToSpring'
    ]),
    async btnDeleteReview() {
      const reviewNo = this.review.reviewNo
      await this.reqDeleteReviewToSpring(reviewNo)
      await this.$router.go(this.$router.currentRoute)
    },
    btnModifyReview() {
      this.$refs.ReviewModifyForm.dialog = true
    }
  }
}
</script>

<style scoped>
.reviewCard {
  margin: 20px
}

.product {
  margin-top: 10px;
}

.noImage {
  border: 1px #eeeeee solid;
  width: 200px;
  height: 150px;
  text-align: center;
  line-height: 150px;
  margin: auto;
}

</style>