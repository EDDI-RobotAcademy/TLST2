<template>
  <v-container>
    <table class="boards" v-if="!questionComments || (Array.isArray(questionComments) && questionComments.length === 0)">
      현재 등록된 댓글이 없습니다!
    </table>
    <table class="boards" v-else v-for="questionComment in questionComments" :key="questionComment.questionCommentNo"
           style="border: solid thin">
      <thead>
      <tr align="left">
        {{ questionComment.commentWriter }}
      </tr>
      </thead>
      <tbody>
      <tr align="left">
        {{ questionComment.comment }}
      </tr>
      </tbody>
    </table>
  </v-container>
</template>

<script>
export default {
  name: "QuestionCommentList",
  data() {
    return {
      commentWriter: this.$store.state.resMember.username,
    }
  },
  props: {
    questionComments: {
      type: Array
    },
  }
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
</style>