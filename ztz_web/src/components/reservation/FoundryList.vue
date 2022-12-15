<template>
  <ul class="foundry-list-box">
    <li v-if="!foundrys || (Array.isArray(foundrys) && foundrys.length === 0)" class="empty_foundry" >
      <p>협력하는 양조장이 없습니다.</p>
    </li>
    <li v-else v-for="foundry in foundrys" :key="foundry.foundryId" class="active-tab tab" >
      <foundry-card :foundry="foundry" />
    </li>
  </ul>
</template>

<script>
import FoundryCard from "@/components/reservation/FoundryCard.vue";

export default {
  name: "FoundryList",
  components: {FoundryCard},
  props: {
    foundrys: {
      type: Array
    }
  },
}
</script>

<style scoped>

</style>