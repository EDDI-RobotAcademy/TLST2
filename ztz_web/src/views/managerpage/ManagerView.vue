<template>
  <div class="wrap">
    <manager-page-profile-section />
    <manager-page-navi-tabs />
  </div>
</template>

<script>
import "@/css/initialization.css";
import ManagerPageProfileSection from "@/components/managerpage/ManagerPageProfileSection";
import ManagerPageNaviTabs from "@/components/managerpage/ManagerPageNaviTabs";

export default {
  name: "ManagerView",
  components: {ManagerPageProfileSection, ManagerPageNaviTabs}
}
</script>

<style scoped>

</style>