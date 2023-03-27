<template>
  <v-container>
    <v-tabs
      v-model="active_tab"
      fixed-tabs
      background-color="white"
      color="#205C37"
    >
      <v-tab
        :key="i"
        v-for="(item, i) in navi"
        v-on:click="currentTab = item.tab"
      >
        {{ item.menu }}
      </v-tab>
    </v-tabs>

    <keep-alive>
      <component :is="componentLoader"></component>
    </keep-alive>
  </v-container>
</template>

<script>
export default {
  name: "MyPageNaviTabs",
  props: {
    name: {
      type: String,
      default: "",
    },
    index: {
      type: Number,
      default: 0,
    },
  },
  data() {
    return {
      currentTab: "OrderManagement",
      active_tab: 0,
      navi: [
        { menu: "주문관리", tab: "OrderManagement" },
        { menu: "리뷰관리", tab: "MyPageReviewForm" },
        { menu: "예약관리", tab: "MyReservationDetailSection" },
        { menu: "찜한상품", tab: "MyFavoriteForm" },
        { menu: "1:1 문의", tab: "MyPageQuestionForm" },
        { menu: "배송지관리", tab: "MyPageDeliverySection" },
        { menu: "회원정보변경", tab: "MyPageProfileModify" },
      ],
    };
  },
  mounted() {
    this.active_tab = this.index;
  },
  computed: {
    componentLoader() {
      const tab = this.currentTab;
      return () => import(`@/components/mypage/${tab}`);
    },
  },
  methods: {},
};
</script>
