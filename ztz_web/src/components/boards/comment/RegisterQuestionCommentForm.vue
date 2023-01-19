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
                  btn-name="등록하기"
                  @click="registerComment"
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
  name: "RegisterQuestionCommentForm",
  data () {
    return {
      questionContent: this.questionBoard.content,
      comment: '',
    }
  },
  methods: {
    ...mapActions([
        'requestQuestionCommentRegisterToSpring'
    ]),
    async registerComment() {
      const {comment} = this
      const memberId = this.resMember.id
      const questionNo = this.questionBoard.questionNo
      await this.requestQuestionCommentRegisterToSpring({comment, memberId, questionNo})
      await this.$router.go(this.$router.currentRoute)
    }
  },
  props: {
    questionBoard: Object,
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

.board-items p {
  margin-top: 10px;
  margin-right: 50px;
}

</style>