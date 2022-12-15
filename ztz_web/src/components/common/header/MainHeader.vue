<template>
  <div>
  <v-container >
    <div>
      <v-row justify="center">
        <v-col cols="auto">
          <router-link to="/">
            <v-img
                :src="require('@/assets/ztz_logo1.png')" width="120" />
          </router-link>

        </v-col>
        <v-col >
          <div style="font-size:20px;">
            <v-row class="mt-16">
              <v-col class="col-12 col-sm-4">
                <router-link style="text-decoration: none; font-weight: bold; " to="/product">
                  <p class="light-green--text text--darken-3" align="center">전통주</p>
                </router-link>
              </v-col>
              <v-col class="col-12 col-sm-4">
                <router-link style="text-decoration: none; font-weight: bold" to="/">
                  <p class="light-green--text text--darken-3" align="center">이달의 술</p>
                </router-link>
              </v-col>
              <v-col class="col-12 col-sm-4">
                <router-link style="text-decoration: none; font-weight: bold" to="/">
                  <p class="light-green--text text--darken-3" align="center">양조체험</p>
                </router-link>
              </v-col>
            </v-row>
         </div>
        </v-col>

        <v-col cols="auto" v-if="this.$store.state.isAuthenticated">
          <v-btn small text @click="logout">로그아웃</v-btn>
          <v-btn small text @click="goMyPage">마이페이지</v-btn>
        </v-col>

        <v-col cols="auto" v-else>
          <v-btn small text @click="goSignIn">로그인</v-btn>
          <v-btn small text @click="goSignUp">회원가입</v-btn>
        </v-col>

      </v-row>

    </div>
  </v-container>

  <div>
    <v-divider style="border-color: #205C37; border-width:1px;"></v-divider>
  </div>
  </div>
</template>

<script>
import {mapState} from "vuex";

export default {
  name: 'MainHeader',
  computed: {
      ...mapState([
      'isAuthenticated'
    ]),
  },
  data() {
    return {
    }
  },
  methods:{
    async logout() {
      console.log("로그아웃합니다")
      this.$store.commit('IS_AUTHENTICATED', false)
      localStorage.removeItem("userInfo")
      this.$cookies.remove('user')
      alert('로그아웃 되었습니다.')
      await this.$router.push({name:'SignInView'})
    },
    goMyPage() {
      this.$router.push({name:'MyPageView'})
    },
    goSignIn(){
      this.$router.push({name:'SignInView'})
    },
    goSignUp(){
      this.$router.push({name:'SignUpView'})
    },
  }
}
</script>