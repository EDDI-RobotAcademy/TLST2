<template>
  <div class="wrap myReview">
    <div class="l">
      <my-page-profile-section/>
    </div>
    <div class="r">
      <my-page-review-form :member-id="memberId"/>
    </div>
  </div>


</template>

<script>
import MyPageProfileSection from "@/components/mypage/MyPageProfileSection";
import MyPageReviewForm from "@/components/mypage/MyPageReviewForm";
export default {
  name: "MyPageReview",
  components: {MyPageReviewForm, MyPageProfileSection},
  props: {
    memberId: String
  }
}
</script>

<style scoped>
.myReview {
  width: 1200px;
  margin: 0 auto;
  padding: 40px 0;
  display: flex;
  justify-content: space-evenly;
}

.myReview .l {
  width: 400px;
}

.myReview .r {
  width: 800px;
  border-left: 1px solid #eee;
}

</style>