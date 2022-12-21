<template>
  <v-app>
    <div id="app">
      <v-main>
        <main-header v-if="!$route.meta.hideHeader" />
        <router-view />
        <new-footer />
      </v-main>
    </div>
  </v-app>
</template>

<script>
export default {
  name: "App",

  data: () => ({
    //
  }),
};
</script>

<style scoped>
#app {
  height: 100%;
  position: relative;
  font-family: "naver2";
}

</style>
