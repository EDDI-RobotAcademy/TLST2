<template>
  <footer>
    <v-card flat tile class="basil lighten-4 basil--text text-center">

      <v-divider></v-divider>

      <v-row class="mt-8" style="font-size:15px;">
        <v-col class="col-6 col-sm-4">
          <router-link style="text-decoration: none; font-weight: bold; " to="/question-list" >
            <p align="right" style="color: #205C37">질문게시판</p>
          </router-link>
        </v-col>
      </v-row>

      <v-card-text class="basil--text pt-10" style="font-size : 13px" >
        전통주류판매영업2팀  | 박진주, 임보경, 최재민, 김가람, 박근수
      </v-card-text>
      <v-card-text class="basil--text pb-10" style="font-size : 12px" >
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