<template>
  <div class="wrap">
    <div class="question-board">
      <div>
        <div style="text-align: center; margin-bottom: 10px">
          <h1>Q&A</h1>
        </div>
        <question-list-form :questionBoards="questionBoards"/> <!-- 중요 : 앞하고 뒤 무조건 소문자로 시작 -->
      </div>
      <div style="float: right" class="mr-5 mb-15">
        <button-white
            depressed
            btn-name="문의하기"
            @click="registerBoard"/>
        <template>
          <v-dialog v-model="showRegisterBoard" max-width="1000">
            <register-question-board-form/>
          </v-dialog>
        </template>
      </div>
    </div>
  </div>
</template>

<script>
import {mapState, mapActions} from "vuex";
import QuestionListForm from "@/components/boards/QuestionListForm";
import RegisterQuestionBoardForm from "@/components/boards/RegisterQuestionBoardForm";

export default {
  name: "QuestionListView",
  components: {
    RegisterQuestionBoardForm,
    QuestionListForm,
  },
  computed: {
    ...mapState([
      'questionBoards'
    ]),
  },
  data() {
    return {
      isLogin: false,
      showRegisterBoard: false,
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
    registerBoard() {
      if (this.isLogin == false) {
        alert("로그인이 필요한 기능입니다.")
        this.$router.push("/sign-in")
      } else {
        this.showRegisterBoard = true
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
.question-board {
  padding-top: 50px;
  padding-bottom: 50px;
}
</style>