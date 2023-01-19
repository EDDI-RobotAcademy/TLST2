<template>
  <v-card>
    <v-card-title></v-card-title>
    <div class="comment-title">
      <p style="font-size: 22px; font-weight: bold">답변등록</p>
    </div>
    <v-divider style="border-color: black; border-width: 1px"></v-divider>
    <div class="comment-container">
      <div class="comment-items">
        <v-row>
          <v-col cols="2">
            <p>문의내용</p>
          </v-col>
          <v-col cols="10">
            <v-textarea
                color="black"
                height="200px"
                v-model="questionContent"
                readonly
                outlined>
            </v-textarea>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="2" align="right">
            <p>답변</p>
          </v-col>
          <v-col cols="10">
            <v-textarea
                color="black"
                height="200px"
                placeholder="답변을 작성해주세요"
                v-model="comment"
                outlined>
            </v-textarea>
          </v-col>
        </v-row>
        <v-row align="center">
          <v-col>
            <div align="center" class="mb-10">
              <button-green
                  btn-name="수정하기"
                  @click="modifyComment"
                  style="width: 200px; height: 50px; font-size: 16px">
              </button-green>
            </div>
          </v-col>
        </v-row>
      </div>
    </div>
  </v-card>
</template>

<script>
import {mapActions, mapState} from "vuex";

export default {
  name: "ModifyQuestionCommentForm",
  data () {
    return {
      questionContent: this.questionBoard.content,
      comment: this.questionComment.comment,
    }
  },
  methods: {
    ...mapActions([
        'reqModifyQuestionCommentToSpring'

    ]),
    async modifyComment() {
      const memberId = this.resMember.id
      const questionNo = this.questionBoard.questionNo
      const questionCommentNo = this.questionComment.questionCommentNo
      const {comment} = this
      await this.reqModifyQuestionCommentToSpring({memberId, questionNo, comment, questionCommentNo})
      await this.$router.go(this.$router.currentRoute)

    }
  },
  props: {
    questionBoard: Object,
    questionComment: Object,
  },
  computed: {
    ...mapState([
      'resMember'
    ])
  }
}
</script>

<style scoped>


.comment-title {
  margin-left: 30px;
}

.comment-container {
  display: flex;
  justify-content: center;
}

.comment-items {
  margin-top: 40px;
  text-align: right;
  padding-right: 50px;
  width: 1000px;
}

</style>