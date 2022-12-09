<template>
  <div class="wrap foundryView">
    <p class="menu-head-text">TOUR + EXPERIENCE</p>
    <foundry-list />
  </div>
</template>
<script>
import "@/css/initialization.css";
import FoundryList from "@/components/reservation/FoundryList.vue";
export default {
  name: "FoundryView",
  components: {FoundryList},
};
</script>
