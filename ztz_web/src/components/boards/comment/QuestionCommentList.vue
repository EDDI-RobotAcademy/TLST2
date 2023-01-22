<template>
  <v-container>
    <table class="boards"
           style="background-color: #eeeeee; border-radius: 10px"
           v-if="!questionComments || (Array.isArray(questionComments) && questionComments.length === 0)">
      <div style="padding: 10px">
        <p>현재 등록된 댓글이 없습니다!</p>
      </div>
    </table>
    <table class="boards"
           style="background-color: #eeeeee; border-radius: 10px"
           v-else
           v-for="questionComment in questionComments" :key="questionComment.questionCommentNo"
    >
      <tbody>
      <!--      댓글 리스트-->
      <tr>
        <div class="comment">
          <v-row>
            <pre style="font-family: naver2; height: fit-content">{{ questionComment.comment }}
            </pre>
          </v-row>
          <v-row>
            <p class="mt-2">{{ questionComment.regDate }}</p>
          </v-row>
          <v-row v-if="resMember.managerCheck" justify="end" class="mr-5 mb-5">
            <button @click="modifyComment" class="mr-3">수정</button>
            <button @click="onCommentDelete(questionComment.questionCommentNo)">삭제</button>
          </v-row>
          <template>
            <v-dialog v-model="showModifyComment" max-width="1000">
              <modify-question-comment-form
                  :question-board="questionBoard"
                  :question-comment="questionComment"/>
            </v-dialog>
          </template>
        </div>
      </tr>
      </tbody>
    </table>
  </v-container>
</template>

<script>

import {mapActions, mapState} from "vuex";
import ModifyQuestionCommentForm from "@/components/boards/comment/ModifyQuestionCommentForm";

export default {
  name: "QuestionCommentList",
  components: {ModifyQuestionCommentForm},
  data() {
    return {
      commentWriter: this.$store.state.resMember.username,
      deleteDialog: false,
      deleteCommentTitle: "댓글 삭제",
      showModifyComment: false
    }
  },
  props: {
    questionComments: {
      type: Array
    },
    questionBoard: {
      type: Object
    }
  },
  computed: {
    ...mapState(['resMember'])
  },
  methods: {
    ...mapActions([
      'requestDeleteQuestionCommentToSpring',
      'reqMemberInfoToSpring'
    ]),
    async onCommentDelete(commentNo) {
      const questionCommentsNo = commentNo;
      await this.requestDeleteQuestionCommentToSpring(questionCommentsNo);
      await this.$router.push({name: 'QuestionListView'})
    },
    modifyComment() {
      this.showModifyComment = true
    }
  },
}
</script>

<style scoped>

table.boards {
  text-align: left;
  line-height: 1.5;
  /*border: 1px solid;*/
  width: 600px;
  table-layout: fixed;
}

table.boards thead {
  background: darkseagreen;
  font-weight: bold;
}

.boards .comment {
  padding-left: 20px;
  padding-top: 15px;
  margin: 10px;

}

.boards .comment .comment-btn {
  padding-left: 15px;
  color: white;
  margin-left: 370px;
}
</style>