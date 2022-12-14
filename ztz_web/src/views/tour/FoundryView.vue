<template>
  <div class="wrap foundryView">
    <p class="menu-head-text">TOUR + EXPERIENCE</p>
    <foundry-list :foundrys = "foundrys"></foundry-list>
  </div>
</template>
<script>
import "@/css/initialization.css";
import FoundryList from "@/components/tour/FoundryList.vue";

import { mapState, mapActions } from "vuex";

export default {
  name: "FoundryView",
  components: {FoundryList},
  computed: {
    ...mapState([
      'foundrys'
    ]),
  },
  mounted() {
    this.reqFoundryListFromSpring()
  },
  methods: {
    ...mapActions([
      'reqFoundryListFromSpring',
    ]),
  },
};
</script>
