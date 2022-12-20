<template>
  <v-app>
      <div id="app">
        <v-main>
          <main-header v-if="!$route.meta.hideHeader"/>
          <router-view/>
          <main-footer/>
        </v-main>
      </div>
  </v-app>
</template>

<script>

export default {
  name: 'App',

  data: () => ({
    //
  }),
};
</script>

<style scoped>

#app {
  height: 100%;
  position: relative;
}
</style>
