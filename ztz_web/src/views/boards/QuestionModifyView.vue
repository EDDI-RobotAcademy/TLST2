<template>
  <v-container>
    <div align="center">
      <h2>게시물 수정</h2>
      <question-modify-form v-if="questionBoard" :questionBoard="questionBoard" @submit="onSubmit"/>
      <p v-else>Loading .........</p>
    </div>
  </v-container>
</template>

<script>
import QuestionModifyForm from "@/components/boards/QuestionModifyForm";
import {mapActions, mapState} from "vuex";

export default {
  name: "QuestionModifyView",
  components: {
    QuestionModifyForm,
  },
  props: {
    questionNo: {
      type: String,
      required: true,
    }
  },
  computed: {
    ...mapState(['questionBoard'])
  },
  methods: {
    ...mapActions([
      'requestQuestionFromSpring',
      'requestQuestionModifyToSpring'
    ]),
    async onSubmit (payload) {
      const { title, content, memberId, categoryType} = payload
      const questionNo = this.questionNo
      await this.requestQuestionModifyToSpring({ questionNo, title, content, memberId, categoryType })
      await this.$router.push({
        name: 'QuestionReadView',
        params: { questionNo: this.questionNo }
      })
    }
  },
  created () {
    this.requestQuestionFromSpring(this.questionNo)
  }
}
</script>

<style scoped>

</style>