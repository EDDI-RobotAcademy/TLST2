<template>
  <footer>
    <v-card flat tile class="basil lighten-4 basil--text text-center">
      <v-card-text>
        <v-btn v-for="icon in icons" :key="icon" class="mx-4 basil--text" icon>
          <v-icon size="24px">
            {{ icon }}
          </v-icon>
        </v-btn>
      </v-card-text>

      <v-divider></v-divider>

      <v-card-text class="basil--text pt-0" style="font-size : 13px" >
        전통주류판매영업2팀  | 박진주, 임보경, 최재민, 김가람, 박근수
      </v-card-text>
      <v-card-text class="basil--text pt-0" style="font-size : 12px" >
        copyright(c) TLST2 all rights reserved.
      </v-card-text>

      <v-divider></v-divider>

    </v-card>
  </footer>
</template>

<script>
export default {
  name: "MainFooter",
  data() {
    return{
    }
  }
}
</script>

<style scoped>

footer {
  margin-top: 100px;
  font-size: 10px;
}
</style>