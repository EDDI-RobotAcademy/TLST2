<template>
  <v-container>
    <div align="center">
      <h2>게시물 작성</h2>
      <question-register-form @submit="onSubmit"/>
    </div>
  </v-container>
</template>

<script>
import QuestionRegisterForm from "@/components/boards/QuestionRegisterForm";
import {mapActions} from "vuex";

export default {
  name: "QuestionRegisterView",
  components: {
    QuestionRegisterForm,
  },
  methods: {
    ...mapActions([
      'requestCreateQuestionContentsToSpring'
    ]),
    async onSubmit (payload) {
      await this.requestCreateQuestionContentsToSpring(payload)
      await this.$router.push({
        name: 'QuestionListView'
      })
    }
  }
}
</script>

<style scoped>

</style>