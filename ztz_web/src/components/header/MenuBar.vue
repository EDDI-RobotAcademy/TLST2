<template>
  <v-toolbar color="black" elevation="0" rounded dense>
    <v-toolbar-items v-if="!isMobile()">
      <v-btn
          class="black-1 white--text"
          elevation="0"
          v-for="link in links" :key="link.text" :to="link.route">
        <v-icon>{{link.icon}}</v-icon>
        <span style="width: 6px" v-if="link.text"></span>
        {{ link.text }}
      </v-btn>
    </v-toolbar-items>
    <v-toolbar-items v-else>>
      <v-btn
          class="black-1 white--text"
          elevation="0"
          v-for="link in links" :key="link.text" :to="link.route">
        <v-icon>{{link.icon}}</v-icon>
      </v-btn>
    </v-toolbar-items>
  </v-toolbar>
</template>

<script>
export default {
  name: "CommonMenuBar",
  data() {
    return {
    }
  }
}
</script>

<style scoped>

</style>