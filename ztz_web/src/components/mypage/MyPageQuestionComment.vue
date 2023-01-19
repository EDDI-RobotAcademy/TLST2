<template>
  <div>
    <div v-if="!questionComments || (Array.isArray(questionComments) && questionComments.length === 0)">
      <v-row justify="end">
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
    </div>
    <div v-else>
      <v-row>
        <v-img
            :src="require('@/assets/board/letter-a.png')"
            max-width="20px"
            max-height="20px"
            contain></v-img>
        <pre class="ml-3" style="font-family: naver2">{{ this.questionComments[0].comment }}
          <p style="color: gray; font-size: 13px">{{ this.questionComments[0].regDate}}</p>
        </pre>
      </v-row>
    </div>
  </div>

</template>

<script>
import {mapActions, mapState} from "vuex";
import ModifyQuestionBoardForm from "@/components/boards/ModifyQuestionBoardForm";

export default {
  name: "MyPageQuestionComment",
  components: {ModifyQuestionBoardForm},
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
  },
  mounted() {
    this.requestQuestionCommentListFromSpring(this.questionBoard.questionNo)
  },
  computed: {
    ...mapState([
        'questionComments',
    ])
  }
}
</script>

<style scoped>

</style>