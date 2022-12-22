<template>
  <div class="wrap">
    <h2>{{ $route.params.name }}</h2>

    <my-page-navi-tabs :name="name" :index="index" />
  </div>
</template>
<script>
import "@/css/initialization.css";
import MyPageNaviTabs from "@/components/mypage/MyPageNaviTabs.vue";

export default {
  name: "MypageDetailView",
  components: { MyPageNaviTabs },
  props: {
    name: {
      type: String,
      default: "",
    },
    index: {
      type: Number,
      default: 0
    }
  },
  data() {
    return {
      
    };
  },
  mounted() {

  },
};
</script>
