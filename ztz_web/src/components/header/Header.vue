<template>
  <v-container>
    <div>
      <v-row justify="center">
        <v-col cols="auto">
          <router-link to="/">
            <v-img
                :src="require('.png')" width="180" class="ma-2" />
          </router-link>

        </v-col>

        <v-col cols="auto">
          <router-link to="/sign-in"> 회원가입 </router-link> &nbsp;
          <router-link to="/sign-up"> 로그인 </router-link> &nbsp;
          <router-link to="/sign-up"> 로그아웃 </router-link> &nbsp;
          <router-link to="/sign-up"> 마이페이지 </router-link> &nbsp;
        </v-col>
      </v-row>
      <common-menu-bar/>
    </div>
  </v-container>
</template>

<script>
import CommonMenuBar from "@/components/header/MenuBar";

export default {
  name: "CommonMainMenuBar",
  components:{
    CommonMenuBar
  },
  data() {
    return{
      message: "",
    }
  },
  methods: {
    }
}
</script>

<style scoped>
 {
  text-decoration: none;
}
</style>