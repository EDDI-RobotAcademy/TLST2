<template>
  <div>
    <div v-if="!questionComments || (Array.isArray(questionComments) && questionComments.length === 0)">
      <v-row justify="end" v-if="!this.resMember.managerCheck">
        <div class="mr-3">
          <button @click="btnModifyBoard">수정</button>
          <template>
            <v-dialog v-model="showModifyBoard" max-width="1000">
              <modify-question-board-form :question-board="questionBoard"/>
            </v-dialog>
          </template>
        </div>
        <div>
          <button @click="btnDeleteBoard">삭제</button>
        </div>
      </v-row>
      <v-row justify="end" v-else>
        <div class="mr-3">
          <button @click="btnRegisterComment">답변등록</button>
<!--          <button-white btn-name="답변등록"/>-->
          <template>
            <v-dialog v-model="showRegisterComment" max-width="1000">
              <register-question-comment-form :question-board="questionBoard"/>
            </v-dialog>
          </template>
        </div>
      </v-row>
    </div>
    <div v-else>
      <v-row>
        <v-img
            :src="require('@/assets/board/letter-a.png')"
            max-width="20px"
            max-height="20px"
            contain></v-img>
        <pre class="ml-3" style="font-family: naver2">{{ this.questionComments[0].comment }}</pre>
      </v-row>
    </div>
  </div>

</template>

<script>
import {mapActions, mapState} from "vuex";
import ModifyQuestionBoardForm from "@/components/boards/ModifyQuestionBoardForm";
import RegisterQuestionCommentForm from "@/components/boards/comment/RegisterQuestionCommentForm";

export default {
  name: "MyPageQuestionComment",
  components: {RegisterQuestionCommentForm, ModifyQuestionBoardForm},
  data () {
    return {
      showModifyBoard: false,
      showRegisterComment: false,
    }
  },
  props: {
    questionBoard: Object,
  },
  methods: {
    ...mapActions([
        'requestQuestionCommentListFromSpring',
        'requestDeleteQuestionToSpring'
    ]),
    btnModifyBoard() {
      this.showModifyBoard = true
    },
    async btnDeleteBoard() {
      await this.requestDeleteQuestionToSpring(this.questionBoard.questionNo)
      await this.$router.go(this.$router.currentRoute)
    },
    btnRegisterComment() {
      this.showRegisterComment = true
    }
  },
  mounted() {
    this.requestQuestionCommentListFromSpring(this.questionBoard.questionNo)
  },
  computed: {
    ...mapState([
        'questionComments',
        'resMember'
    ])
  }
}
</script>

<style scoped>

</style>