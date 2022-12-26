<template>
  <v-container>
    <div id="question-board">
      <h1>상품 Q&A</h1>
      <br/>
      <question-list-form :questionBoards="questionBoards"/> <!-- 중요 : 앞하고 뒤 무조건 소문자로 시작 -->
    </div>
    <br/>
    <div style="float: right" class="mb-10">
      <router-link :to="{ name: 'QuestionRegisterView' }">
        <button-white depressed btn-name="게시글 작성"
               v-if="isLogin == false" @click.prevent="registerAccess"/>
        <button-white btn-name="게시글 작성" depressed v-else/>
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