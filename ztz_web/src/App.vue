<template>
  <div id="app">
    <v-main>
      <router-view/>
    </v-main>
  </div>
</template>

<script>

export default {
  name: "App",
  components: {
  },
  computed: {
    }
}
</script>

<style scoped>

#app {
  height: 100%;
  position: relative;
  padding-bottom: 170px;
}
</style>

