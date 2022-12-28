<template>
  <v-container>
    <table class="boards" v-if="!questionComments || (Array.isArray(questionComments) && questionComments.length === 0)">
      현재 등록된 댓글이 없습니다!
    </table>
    <table class="boards" v-else v-for="questionComment in questionComments" :key="questionComment.questionCommentNo"
           style="border: solid thin">
      <thead>
      <tr>
        <div>
          {{ questionComment.commentWriter }}
        </div>

      </tr>
      </thead>
      <tbody>
      <!--      댓글 리스트-->
      <tr>
        <v-row class="comment">
          {{ questionComment.comment }}
          <!--        댓글 삭제-->
          <div v-if="questionComment.member.id === resMember.id" >
            <v-btn @click="onCommentDelete(questionComment.questionCommentNo)" color="#205C37" class="comment-btn" rounded depressed small v-on="on">
              삭제
            </v-btn>
          </div>
        </v-row>
      </tr>
      </tbody>
    </table>
  </v-container>
</template>

<script>

import {mapActions, mapState} from "vuex";

export default {
  name: "QuestionCommentList",
  data() {
    return {
      commentWriter: this.$store.state.resMember.username,
      deleteDialog: false,
      deleteCommentTitle:"댓글 삭제",
    }
  },
  props: {
    questionComments: {
      type: Array
    },
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
  },
}
</script>

<style scoped>

table.boards {
  text-align: left;
  line-height: 1.5;
  border: 1px solid;
  width: 570px;
  table-layout: fixed;
}
table.boards thead {
  background: darkseagreen;
  font-weight: bold;
}
.boards .comment{
  padding-left: 15px;
  padding-top: 15px;
  padding-bottom: 15px;
}
.boards .comment .comment-btn{
  padding-left: 15px;
  color: white;
  margin-left: 370px;
}
</style>