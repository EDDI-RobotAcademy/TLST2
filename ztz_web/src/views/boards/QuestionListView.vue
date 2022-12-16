<template>
  <v-container>
    <div id="question-board">
      <h1>상품 Q&A</h1>
      <br/>
      <question-list-form :questionBoards="questionBoards"/> <!-- 중요 : 앞하고 뒤 무조건 소문자로 시작 -->
    </div>
    <br/>
    <div style="float: right">
      <router-link :to="{ name: 'QuestionRegisterView' }">
        <v-btn class="green white--text" rounded depressed small
               v-if="isLogin == false" @click.prevent="registerAccess">
          게시물 작성
        </v-btn>
        <v-btn class="green white--text" rounded depressed small v-else>
          게시글 작성
        </v-btn>
      </router-link>
    </div>
  </v-container>
</template>

<script>
import { mapState, mapActions } from "vuex";
import QuestionListForm from "@/components/boards/QuestionListForm";

export default {
  name: "QuestionListView",
  components: {
    QuestionListForm,
  },
  computed: {
    ...mapState([
      'questionBoards'
    ]),
  },
  data() {
    return {
      isLogin: false
    }
  },
  mounted() {
    this.requestQuestionListFromSpring()
    if (this.$store.state.isAuthenticated != false) {
      this.isLogin = true
    } else {
      this.isLogin = false
    }
  },
  methods: {
    registerAccess() {
      if(this.isLogin == false) {
        alert("로그인이 필요한 기능입니다.")
        this.$router.push("/sign-in")
      }
    },
    ...mapActions([
      'requestQuestionListFromSpring'
    ])
  }
}
</script>

<style scoped>
a {
  text-decoration: none;
}
</style>