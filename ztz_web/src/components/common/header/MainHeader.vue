<template>
  <div class="header-wrap">
    <div class="header-top">
      <p v-if="this.$store.state.isAuthenticated">
        안녕하세요, {{ this.$store.state.resMember.username }}님! &nbsp;
        ZTZ 멤버십 특별 혜택!</p>
      <p v-else>회원가입 시 전구매 무료 배송, 첫 구매 시 사은품 증정</p>
    </div>
    <div class="header-container">

      <div class="inner-box">
        <div class="left-box">
          <div class="logo">
            <router-link to="/" @click.native="btnNoSearch">
              <v-img :src="require('@/assets/logo/ztz_logo1.png')" width="110px"/>
            </router-link>
          </div>

          <div class="nav" v-for="(item, idx) in nav" :key="idx">
            <v-row>
              <v-col class="nav-item mb-2" v-if="!item.children">
                <router-link
                    style="text-decoration: none;"
                    :to="item.link" @click.native="btnNoSearch">
                  <p>{{ item.name }}</p>
                </router-link>
              </v-col>
<!--              전통주-->
              <v-col class="nav-item" v-else>
                <span @mouseover="mouseover" @mouseleave="mouseleave">
                  <router-link
                      style="text-decoration: none;"
                      :to="item.link" @click.native="btnNoSearch">
                    <p>{{ item.name }}</p>
                  </router-link>
                  <ul class="dropdown"
                      :class="{ isOpen }"
                  >
                    <li v-for="(child, idx) in item.children" :key="idx" >
                      <router-link :to="item.link" class="dropdown-router" @click.native="filterAlcoholType(idx)">
                        <p>{{ child.name }}</p>
                      </router-link>
                    </li>
                  </ul>
                </span>
              </v-col>
            </v-row>
          </div>
        </div>

        <div class="right-box">
          <div class="nav-util">
            <div v-if="showSearch">
              <v-text-field v-model= "keyword"
                            ref="keyword"
                            label="검색어를 입력해주세요"
                            type="text"
                            append-icon="mdi-magnify"
                            @click:append="search"/>
            </div>
            <div v-else>
            <v-btn large elevation="0" text @click="btnSearch">
              <v-icon> mdi-magnify</v-icon>
            </v-btn>
            </div>
            <v-btn large elevation="0" text @click="goCartPage">
              <v-icon> mdi-cart-outline</v-icon>
            </v-btn>

          </div>
          <div class="nav-account">
            <!-- 로그인 시 상단 메뉴 상태 변경 -->
            <v-row v-if="this.$store.state.isAuthenticated">
              <div v-if="this.$store.state.resMember.managerCheck">
                <v-btn large text @click="logout">로그아웃</v-btn>
                <v-btn large text @click="goManagerPage">관리자페이지</v-btn>
              </div>
              <div v-else>
                <v-btn large text @click="logout">로그아웃</v-btn>
                <v-btn large text @click="goMyPage">마이페이지</v-btn>
              </div>
            </v-row>
            <!-- 비로그인 시 상단 메뉴 상태 변경 -->
            <v-row v-else>
              <v-btn large text @click="goSignIn">로그인</v-btn>
              <v-btn large text @click="goSignUp">회원가입</v-btn>
            </v-row>
          </div>
        </div>
      </div>
    </div>
    <v-divider></v-divider>
  </div>
</template>

<script>
import {mapActions, mapState} from "vuex";

export default {
  name: "MainHeader",
  computed: {
    ...mapState(["isAuthenticated", "resMember"]),
  },
  data() {
    return {
      selectMenu: "none",
      isOpen: false,
      nav: [
        {
          name: '전통주',
          link: '/product',
          children: [
            {name: '소주증류주', link: '/product'},
            {name: '리큐르', link: '/product'},
            {name: '막걸리', link: '/product'},
            {name: '약주청주', link: '/product'},
            {name: '과실주', link: '/product'},
            {name: '기타주류', link: '/product'},
          ]
        },
        {
          name: '이달의 술',
          link: '/month'
        },
        {
          name: '양조 체험',
          link: '/tour',
        },
      ],
      showSearch: false,
      keyword: '',
    }
  },
  mounted() {
    if (this.$store.state.isAuthenticated === true) {
      let token = window.localStorage.getItem("userInfo");
      this.reqMemberInfoToSpring(token);
    }
  },
  methods: {
    ...mapActions([
      "reqMemberInfoToSpring",
      "reqCartListFromSpring",
      "reqFilteredAlcoholProductsFromSpring",
      "reqProductsFromSpring"
    ]),
    async logout() {
      console.log("로그아웃합니다");
      this.$store.commit("IS_AUTHENTICATED", false);
      localStorage.removeItem("userInfo");
      this.$cookies.remove("user");
      alert("로그아웃 되었습니다.");
      await this.$router.push({name: "SignInView"});
      this.showSearch = false
    },
    goMyPage() {
      this.$router.push({name: "MyPageView"});
      this.showSearch = false
    },
    goSignIn() {
      this.$router.push({name: "SignInView"});
      this.showSearch = false
    },
    goSignUp() {
      this.$router.push({name: "SignUpView"});
      this.showSearch = false
    },
    goCartPage() {
      this.$router.push({name: "CartView"});
      this.showSearch = false
    },
    goManagerPage(){
      alert("관리자페이지")
      this.showSearch = false
    },
    mouseover() {
      this.isOpen = true;
    },
    mouseleave() {
      this.isOpen = false;
    },
    async filterAlcoholType(index){
      console.log("상품 필터 알콜메뉴명:" + this.nav[0].children[index].name )
      let alcoholType = this.nav[0].children[index].name
      await this.reqFilteredAlcoholProductsFromSpring(alcoholType)
    },
    btnSearch(){
      this.showSearch = true
      this.$router.push('/product')
    },
    btnNoSearch(){
      this.showSearch = false
    },
    async search(){
        const keyword = this.$refs.keyword.value
        await this.reqProductsFromSpring(keyword)
    }
  }
}

</script>

<style scoped>

.header-top {
  display: flex;
  background-color: #205C37;
  height: 28px;
}

.header-top p {
  margin: auto;
  color: white;
}

.logo {
  width: 110px;
}

.header-container {
  margin: 24px 100px 24px 100px;
}

.inner-box {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.left-box {
  display: flex;
  align-items: center;
  justify-content: flex-start;
}

.left-box .nav {
  display: flex;
  align-items: center;
  margin-top: 30px;
  margin-left: 20px;
}

.left-box .nav .nav-item {
  position: relative;
  width: 200px;
}

.nav p {
  color: #205C37;
  font-size: 20px;
  font-weight: bold;
  text-align: center;
}

.right-box {
  display: flex;
  align-items: center;
}

.right-box .nav-util {
  display: flex;
  align-items: center;
  margin-right: 45px;
}

.right-box .nav-account {
  display: flex;
}

.nav-item span {
  position: relative;
  display: block;
  height: 50px;
  text-decoration: none;
  cursor: pointer;
}

.dropdown {
  position: absolute;
  top: 100%;
  left: 0;
  display: none;
  padding: 0;
  list-style-type: none;
  background-color: white;
  z-index: 10000;
  border: 1px solid #eeeeee;
  font-size: 10px;
}

.dropdown li {
  width: 170px;
  border-bottom: 1px solid #eeeeee;
}

.dropdown-router {
  display: block;
  padding-top: 20px;
  text-decoration: none;
}

.dropdown-router p {
  font-size: 14px;
}

.isOpen {
  display: block;
}


</style>
