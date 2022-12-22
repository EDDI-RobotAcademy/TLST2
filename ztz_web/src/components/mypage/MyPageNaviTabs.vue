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
      currentTab: "",
      active_tab: 2,
      navi: [
        { menu: "회원정보변경", tab: "TestComponent1" },
        { menu: "배송지관리", tab: "TestComponent1" },
        { menu: "주문관리", tab: "TestComponent1" },
        { menu: "리뷰관리", tab: "TestComponent1" },
        { menu: "예약관리", tab: "MyReservationDetail" },
        { menu: "회원탈퇴", tab: "TestComponent1" },
      ],
    };
  },
  mounted() {
    this.currentTab = this.name;
    this.active_tab = this.index;
    console.log("navi : " + this.currentTab);
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
