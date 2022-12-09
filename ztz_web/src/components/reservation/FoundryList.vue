<template>
  <ul class="foundry-list-box">
    <li class="active-tab tab">
      <foundry-card />
    </li>
    <li class="active-tab tab">
      <foundry-card />
    </li>
    <li class="active-tab tab">
      <foundry-card />
    </li>
  </ul>
</template>

<script>
import FoundryCard from "@/components/reservation/FoundryCard.vue";

export default {
  name: "FoundryList",
  components: {FoundryCard}
}
</script>

<style scoped>

</style>