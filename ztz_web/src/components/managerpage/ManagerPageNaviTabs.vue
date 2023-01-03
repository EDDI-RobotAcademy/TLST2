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
      currentTab: "AllOrderManagement",
      active_tab: 0,
      navi: [
        { menu: "주문관리", tab: "AllOrderManagement" },
        { menu: "상품관리", tab: "ProductManagementList" },
        { menu: "예약관리", tab: "AllReservationDetailSection" },
        { menu: "회원정보변경", tab: "MyPageProfileModify" },
      ],
    };
  },
  mounted() {
    this.active_tab = this.index;
    console.log("navi : " + this.currentTab);
  },
  computed: {
    componentLoader() {
      const tab = this.currentTab;
      if (this.currentTab == "MyPageProfileModify") { return () => import(`@/components/mypage/${tab}`); }
      else { return () => import(`@/components/managerpage/${tab}`); }
    },
  },
  methods: {},
};
</script>
