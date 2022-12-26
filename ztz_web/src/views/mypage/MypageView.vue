<template>
  <div class="wrap">
    <my-page-profile-section />
    <my-page-navi-tabs />
  </div>
</template>
<script>
import "@/css/initialization.css";
import MyPageNaviTabs from "@/components/mypage/MyPageNaviTabs.vue";
import MyPageProfileSection from "@/components/mypage/MyPageProfileSection.vue";
export default {
  name: "MypageView",
  components: {
    MyPageNaviTabs,
    MyPageProfileSection,
  },
};
</script>
