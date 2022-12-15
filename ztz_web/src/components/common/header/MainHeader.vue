<template>
  <div>
    <v-container >
      <div>
        <v-row justify="center">
          <v-col cols="auto">
            <router-link to="/" @click.native="home">
              <v-img
                  :src="require('@/assets/ztz_logo1.png')" width="120" />
            </router-link>
          </v-col>
          <v-col >
            <!-- 메인 메뉴 -->
            <v-row class="mt-16" style="font-size:20px;">
              <v-col class="col-12 col-sm-4">
                <router-link style="text-decoration: none; font-weight: bold; " to="/product" @click.native="alcohol">
                  <p align="center" style="color: #205C37">전통주</p>
                </router-link>
              </v-col>
              <v-col class="col-12 col-sm-4">
                <router-link style="text-decoration: none; font-weight: bold" to="/" @click.native="monthAlcohol">
                  <p align="center" style="color: #205C37">이달의 술</p>
                </router-link>
              </v-col>
              <v-col class="col-12 col-sm-4">
                <router-link style="text-decoration: none; font-weight: bold" to="/" @click.native="brewery">
                  <p align="center" style="color: #205C37">양조체험</p>
                </router-link>
              </v-col>
            </v-row>

          </v-col>

          <!-- 로그인 시 상단 메뉴 상태 변경 -->
          <v-col cols="auto" v-if="this.$store.state.isAuthenticated">
            <v-row>
              <v-col style="padding-right: 0px">
                <h4 class="name" style="margin-top: 11px; padding: 0px;">
                  환영합니다, {{ this.$store.state.resMember.username}}님!
                </h4>
              </v-col>
              <p style="margin-top: 18px; margin-left: 5px; padding: 0px">
                <v-btn x-small elevation="0" text @click="goCartPage">
                  <v-icon>
                    mdi-cart-outline
                  </v-icon>
                </v-btn>
                <v-btn small text @click="logout">로그아웃</v-btn>
                <v-btn small text @click="goMyPage">마이페이지</v-btn>
              </p>
            </v-row>
          </v-col>

          <!-- 비로그인 시 상단 메뉴 상태 변경 -->
          <v-col cols="auto" v-else>
            <v-row>
              <v-col style="padding-right: 0px">
                <h4 class="name" style="margin-top: 11px; padding: 0px;">
                  안녕하세요, 회원님! &nbsp;
                </h4>
              </v-col>
              <p style="margin-top: 18px; margin-left: 5px; padding: 0px">
                <v-btn small text @click="goSignIn">로그인</v-btn>
                <v-btn small text @click="goSignUp">회원가입</v-btn>
              </p>
            </v-row>
          </v-col>

        </v-row>

        <!--서브메뉴 클릭: 전통주 -->
        <v-row v-if="this.selectMenu === 'alcohol'">
          <v-col class="col-12 col-sm-4">
            <router-link style="text-decoration: none; font-weight: bold; " to="/product" @click.native="alcohol">
              <p align="center" style="color: #205C37">증류주</p>
            </router-link>
          </v-col>
          <v-col class="col-12 col-sm-4">
            <router-link style="text-decoration: none; font-weight: bold" to="/" @click.native="monthAlcohol">
              <p align="center" style="color: #205C37">발효주</p>
            </router-link>
          </v-col>
          <v-col class="col-12 col-sm-4">
            <router-link style="text-decoration: none; font-weight: bold" to="/" @click.native="brewery">
              <p align="center" style="color: #205C37">기타 주류</p>
            </router-link>
          </v-col>
        </v-row>

        <!--서브메뉴 클릭: 양조체험 -->
        <v-row v-else-if="this.selectMenu === 'brewery'">
          <v-col class="col-12 col-sm-4">
            <router-link style="text-decoration: none; font-weight: bold; " to="/product" @click.native="alcohol">
              <p align="center" style="color: #205C37">양조장들</p>
            </router-link>
          </v-col>
          <v-col class="col-12 col-sm-4">
            <router-link style="text-decoration: none; font-weight: bold" to="/" @click.native="monthAlcohol">
              <p align="center" style="color: #205C37">예약</p>
            </router-link>
          </v-col>
          <v-col class="col-12 col-sm-4">
            <router-link style="text-decoration: none; font-weight: bold" to="/" @click.native="brewery">
              <p align="center" style="color: #205C37">예약현황</p>
            </router-link>
          </v-col>
        </v-row>

        <!--서브메뉴 클릭: 이달의 술 -->
        <v-row v-else-if="this.selectMenu === 'monthAlcohol'">
          <!-- 서브메뉴 없음 -->
        </v-row>

        <!--서브메뉴 클릭: Home-->
        <v-row v-else>
          <!-- 서브메뉴 없음 -->
        </v-row>

      </div>
    </v-container>
    <div>
      <v-divider style="border-color: #205C37; border-width:1px;"></v-divider>
    </div>
  </div>
</template>

<script>
import {mapActions, mapState} from "vuex";

export default {
  name: 'MainHeader',
  computed: {
    ...mapState([
      'isAuthenticated', 'resMember'
    ]),
  },
  data() {
    return {
      selectMenu: "none",
    }
  },
  mounted() {
    if(this.$store.state.isAuthenticated === true) {
      let token = window.localStorage.getItem('userInfo')
      this.reqMemberInfoToSpring(token)
    }

  },
  methods:{
    ...mapActions([
      'reqMemberInfoToSpring', 'reqCartListFromSpring'
    ]),
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
    goCartPage(){
      this.$router.push({name:'CartView'})
    },
    brewery(){
      this.selectMenu="brewery"
      console.log("셀렉 메뉴: " +this.selectMenu )
    },
    alcohol(){
      this.selectMenu="alcohol"
      console.log("셀렉 메뉴: " +this.selectMenu )
    },
    monthAlcohol(){
      this.selectMenu="monthAlcohol"
      console.log("셀렉 메뉴: " +this.selectMenu )
    },
    home(){
      this.selectMenu="none"
    }
  }
}
</script>
<style scoped>
.name {
  color: #205C37
}
</style>