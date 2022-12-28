<template>
  <v-container>
    <div align="center">
      <div>
        <question-read v-if="questionBoard" :questionBoard="questionBoard"/>
        <p v-else>Loading .......</p>
      </div>
      <div v-if="this.$store.state.resMember.username == this.questionBoard.writer">
        <!--  게시물 수정   -->
        <router-link :to="{ name: 'QuestionModifyView', params: { questionNo } }">
          <button-white depressed btn-name="수정"/>&nbsp;
        </router-link>
        <!--  게시물 삭제   -->
        <v-dialog v-model="deleteDialog" persisten max-width="400">
          <template v-slot:activator="{on}">
            <button-green btn-name="삭제" depressed v-on="on"/>
          </template>
          <v-card>
            <v-card-title class="headline">
              {{ deleteTitle }}
            </v-card-title>
            <v-card-text>
              삭제하시겠습니까?
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="gray darken-2" text @click="cancelBtn">
                취소
              </v-btn>
              <v-btn color="red" text @click="onDelete">
                삭제
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
        <router-link :to="{ name: 'QuestionListView' }">
          <button-white btn-name="BACK" depressed />
        </router-link>
      </div>
      <div v-else>
        <router-link :to="{ name: 'QuestionListView' }">
          <v-btn class="green white--text" rounded depressed small>
            돌아가기
          </v-btn>
        </router-link>
      </div>
      <br/>

      <!--  댓글 삭제    /-->
      <table class="boards">
        <tr>
          <div>
            <h1>댓글</h1>
          </div>
          <div class="comment">
            <question-comment-list :questionComments="questionComments"/>
          </div>
        </tr>
      </table>
      <div>
      <!--  관리자 권한으로 등록할려면 v-if 문 써서 Authenticated, managerCheck 일반 사용자 권한으로 등록할려면 안 써도 된다 -->
        <question-comment-register-form @submit="onSubmitRegister" v-if="this.$store.state.isAuthenticated && this.$store.state.resMember.managerCheck"/>
      </div>
    </div>
  </v-container>
</template>

<script>
import {mapActions, mapState} from "vuex";
import QuestionRead from "@/components/boards/QuestionRead";
import QuestionCommentList from "@/components/boards/comment/QuestionCommentList";
import QuestionCommentRegisterForm from "@/components/boards/comment/QuestionCommentRegisterForm";

export default {
  name: "QuestionReadView",
  data() {
    return {
      deleteTitle:"게시글 삭제",
    }
  },
  components: {
    QuestionRead,
    QuestionCommentList,
    QuestionCommentRegisterForm,
  },
  props: {
    questionNo: {
      type: String,
      required: true
    }
  },
  questionBoard: {
    type: Object,
    required: true
  },
  computed: {
    ...mapState(['questionBoard', 'questionComments', 'resMember'])
  },
  methods: {
    ...mapActions([
      'requestQuestionFromSpring',
      'requestDeleteQuestionToSpring',
      'requestQuestionCommentListFromSpring',
      'requestQuestionCommentRegisterToSpring',
      "reqMemberInfoToSpring",
    ]),
    async onDelete() {
      await this.requestDeleteQuestionToSpring(this.questionNo);
      await this.$router.push({name: 'QuestionListView'})
    },
    async onSubmitRegister( payload ) {
      const { comment, commentWriter, userNumber } = payload
      const questionNo = this.questionNo
      console.log("댓글 등록" + questionNo)
      await this.requestQuestionCommentRegisterToSpring( { comment, commentWriter, questionNo, userNumber} ) // action에서 백엔드 서버 요청, 필요한 데이터들을 보낸다
      await this.$router.push({
        name: 'QuestionReadView', params: { questionNo: this.questionNo }
      })
    },
  },
  created() {
    this.requestQuestionFromSpring(this.questionNo)
    this.requestQuestionCommentListFromSpring(this.questionNo)
  },

  mounted() {
    if (this.$store.state.isAuthenticated === true) {
      let token = window.localStorage.getItem("userInfo");
      this.reqMemberInfoToSpring(token);
    }
  },
}
</script>

<style scoped>

a {
  text-decoration: none;
}

table.boards {
  border-collapse: collapse;
  text-align: left;
  line-height: 1.5;
  border: 1px solid #ccc;
  margin: 20px 10px;
}
table.boards thead {
  border-right: 1px solid #ccc;
  border-left: 1px solid #ccc;
  background: darkseagreen;
}
table.boards thead th {
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  border-right: 1px solid #ccc;
  color: #fff;
}
table.boards tbody th {
  width: 150px;
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
  background: #ececec;
}
table.boards td {
  width: 350px;
  padding: 10px;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
}
.comment {
  display: flex;
  flex-direction: column-reverse;
}

</style>