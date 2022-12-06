<template>
  <div class="wrap mypageWrap">
    <my-page-profile-section />
    <my-page-content-section />
  </div>
</template>

<script>
import MyPageContentSection from "@/components/mypage/MyPageContentSection.vue";
import MyPageProfileSection from "@/components/mypage/MyPageProfileSection.vue";

export default {
  name: "MypageView",
  components: {MyPageProfileSection, MyPageContentSection}
}
</script>

<style scoped>

</style>