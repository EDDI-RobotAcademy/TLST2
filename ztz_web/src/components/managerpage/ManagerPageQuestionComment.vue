<template>
  <div>
    <div v-if="!questionComments || (Array.isArray(questionComments) && questionComments.length === 0)">
      <v-row justify="end">
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
        <pre class="ml-3" style="font-family: naver2">{{ this.questionComments[0].comment }}
          <p style="color:gray; font-size: 13px">{{ this.questionComments[0].regDate}}</p>
        </pre>
      </v-row>
      <v-row class="mt-10">
      </v-row>
      <v-row justify="end">
        <div class="mr-3">
          <button @click="btnModifyComment">수정</button>
          <template>
            <v-dialog v-model="showModifyComment" max-width="1000">
              <modify-question-comment-form
                  :question-board="questionBoard"
                  :question-comment="questionComments[0]"/>
            </v-dialog>
          </template>
        </div>
        <div>
          <button @click="btnDeleteComment">삭제</button>
        </div>
      </v-row>
    </div>
  </div>
</template>

<script>
import {mapActions, mapState} from "vuex";
import RegisterQuestionCommentForm from "@/components/boards/comment/RegisterQuestionCommentForm";
import ModifyQuestionCommentForm from "@/components/boards/comment/ModifyQuestionCommentForm";

export default {
  name: "ManagerPageQuestionComment",
  components: {ModifyQuestionCommentForm, RegisterQuestionCommentForm},
  data () {
    return {
      showRegisterComment: false,
      showModifyComment: false,
    }
  },
  props: {
    questionBoard: Object,
  },
  methods: {
    ...mapActions([
      'requestQuestionCommentListFromSpring',
      'requestDeleteQuestionCommentToSpring'
    ]),
    btnRegisterComment() {
      this.showRegisterComment = true
    },
    btnModifyComment() {
      this.showModifyComment = true
    },
    async btnDeleteComment() {
      await this.requestDeleteQuestionCommentToSpring(this.questionComments[0].questionCommentNo)
      await this.$router.go(this.$router.currentRoute)
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