<template>
  <div class="wrap mypageWrap">
    <my-page-profile-section />
    <my-page-content-section />
  </div>
</template>

<script>
import "@/css/initialization.css";
import MyPageContentSection from "@/components/mypage/MyPageContentSection.vue";
import MyPageProfileSection from "@/components/mypage/MyPageProfileSection.vue";

export default {
  name: "MypageView2",
  components: {MyPageProfileSection, MyPageContentSection}
}
</script>

<style scoped>

</style>