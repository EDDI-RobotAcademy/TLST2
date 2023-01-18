<template>
  <div>
    <div>
      <div class="mt-16 mr-5" align="right">
        <p>총 {{ this.reviews.length }}개의 작성된 리뷰가 있습니다.</p>
      </div>
    </div>
    <div>
      <paginate tag="ul" :list="reviews" name="reviews" :per="5">
        <li v-if="!reviews || (Array.isArray(reviews) && reviews.length === 0)">
          <p class="mt-10" align="center">작성된 리뷰가 없습니다.</p>
        </li>
        <li v-for="(review, idx) in paginated('reviews')" :key="idx" v-else>
          <my-page-review-card :review="review"/>
        </li>
      </paginate>
      <paginate-links for="reviews" :simple="{
          next: 'Next »',
          prev: '« Back'
        }"></paginate-links>
    </div>
  </div>
</template>

<script>
import {mapActions, mapState} from "vuex";
import MyPageReviewCard from "@/components/mypage/MyPageReviewCard";

export default {
  name: "MyPageReviewForm",
  components: {MyPageReviewCard},
  data() {
    return {
      paginate: ['reviews']
    }
  },
  props: {
    memberId: String,
  },
  methods: {
    ...mapActions([
      'reqMyPageReviewFromSpring',
    ])
  },
  mounted() {
    this.reqMyPageReviewFromSpring(this.resMember.id)
  },
  computed: {
    ...mapState([
      'reviews',
      'resMember'
    ])
  }
}
</script>

<style scoped>

</style>