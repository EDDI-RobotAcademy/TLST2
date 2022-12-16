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
          <v-btn class="green white--text" rounded depressed small>게시물 수정</v-btn>&nbsp;
        </router-link>
        <!--  게시물 삭제   -->
        <v-dialog v-model="deleteDialog" persisten max-width="400">
          <template v-slot:activator="{on}">
            <v-btn class="green white--text" rounded depressed small v-on="on">
              삭제
            </v-btn>
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
          <v-btn class="green white--text" rounded depressed small>
            돌아가기
          </v-btn>
        </router-link>
      </div>
      <div v-else>
        <router-link :to="{ name: 'QuestionListView' }">
          <v-btn class="green white--text" rounded depressed small>
            돌아가기
          </v-btn>
        </router-link>
      </div>
    </div>
  </v-container>
</template>

<script>
import {mapActions, mapState} from "vuex";
import QuestionRead from "@/components/boards/QuestionRead";

export default {
  name: "QuestionReadView",
  data() {
    return {
      deleteDialog: false,
      deleteTitle:"게시글 삭제"
    }
  },
  components: {
    QuestionRead,
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
    ...mapState(['questionBoard'])
  },
  methods: {
    ...mapActions([
      'requestQuestionFromSpring',
      'requestDeleteQuestionToSpring',
    ]),
    async onDelete() {
      await this.requestDeleteQuestionToSpring(this.questionNo);
      await this.$router.push({name: 'QuestionListView'})
    },
    cancelBtn() {
      this.deleteDialog = false
    },
  },
  created() {
    this.requestQuestionFromSpring(this.questionNo)
  },
}
</script>

<style scoped>

a {
  text-decoration: none;
}

</style>