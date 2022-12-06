<template>
  <v-container>
    <div>
      <v-row justify="center">
        <v-col cols="auto">
          <router-link to="/">
            <v-img
                :src="require('@/assets/logo.png')" width="180" />
          </router-link>

        </v-col>
          <v-spacer></v-spacer>

        <v-col cols="auto" v-if="this.$store.state.isAuthenticated">
          <v-btn small text @click="logout">로그아웃</v-btn>
          <v-btn small text @click="goMyPage">마이페이지</v-btn>
        </v-col>

        <v-col cols="auto" v-else>
          <v-btn small text @click="goSignIn">로그인</v-btn>
          <v-btn small text @click="goSignUp">회원가입</v-btn>
        </v-col>
      </v-row>

      <v-container>
        <v-row no-gutters>
          <v-col class="col-12 col-sm-4">
            <router-link style="text-decoration: none; font-weight: bold" to="/">
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
      </v-container>

<!--      <v-toolbar elevation="0" rounded dense>-->
<!--        <v-toolbar-items>-->
<!--          <v-btn-->
<!--              class="blue lighten-1 white&#45;&#45;text"-->
<!--              elevation="0"-->
<!--              v-for="link in links" :key="link.text" :to="link.route">-->
<!--            <v-icon>{{link.icon}}</v-icon>-->
<!--            <span style="width: 6px" v-if="link.text"></span>-->
<!--            {{ link.text }}-->
<!--          </v-btn>-->
<!--        </v-toolbar-items>-->
<!--      </v-toolbar>-->

<!--      <div>-->
<!--        <v-menu offset-y>-->
<!--          <template v-slot:activator="{ on }">-->
<!--            <v-btn color="teal darken-1" class="white&#45;&#45;text ma-5" v-on="on">-->
<!--              마! 이거시 Drop Down 이닷!-->
<!--            </v-btn>-->
<!--          </template>-->

<!--          <v-list>-->
<!--            <v-list-item v-for="(dropItem, index) in dropItems" :key="index" link>-->
<!--              <v-list-item-title>-->
<!--                {{ dropItem.title }}-->
<!--              </v-list-item-title>-->
<!--            </v-list-item>-->
<!--          </v-list>-->
<!--        </v-menu>-->
<!--      </div>-->

    </div>
  </v-container>
</template>

<script>
export default {
  name: 'MainHeader',
  computed: {
    //   ...mapState([
    //   'isAuthenticated'
    // ]),
  },
  data() {
    return {
      links: [
        { icon: 'mdi-headphones', text: '홈트영상', name: 'home', route: '/' },
        { icon: 'mdi-calendar-check-outline', text: '전체게시판', name: 'all', route: '/all-board-list' },
        { icon: 'mdi-calendar-check-outline', text: '운동일기', name: 'diary', route: '/diary-board-list' },
        { icon: 'mdi-comment-processing-outline', text: '자유게시판', name: 'free', route: '/free-board-list' },
        { icon: 'mdi-comment-question-outline', text: '질문게시판', name: 'qna', route: '/qna-board-list' },
      ],
      // dropItems: [
      //   { title: '가즈아!!!!!' },
      //   { title: '간드아!!!!!' },
      //   { title: '고고싱!!!!!' },
      //   { title: '달려ㅆ!!!!!' },
      // ],
    }
  }
}
</script>