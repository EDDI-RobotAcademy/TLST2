<template>
  <v-container>
    <form @submit="onSubmitRegister()">
      <table>
        <tbody>
        <br>
        <tr>
          <th scope="row">
            {{ commentWriter }}
          </th>
          &nbsp;&nbsp;&nbsp;
          <td>
          <textarea
              class="justify-center"
              style="border: solid thin"
              cols="60" rows="3" v-model="comment"
              placeholder="내용을 입력해 주세요."
              onfocus="this.placeholder=''"
              onblur="this.placeholder='내용을 입력해 주세요.'">
          </textarea>
          </td>
          <td>
            <v-btn class="ml-3" width="100" height="70" rounded type="submit">
              등록하기
            </v-btn>
          </td>
        </tr>
        </tbody>
      </table>
    </form>
  </v-container>
</template>

<script>

export default {
  name: "QuestionCommentRegisterForm",
  data() {
    return {
      comment: '',
      memberId: this.$store.state.resMember.id, // 변수 지정 -> Request로 보냄
      commentWriter: this.$store.state.resMember.username
    }
  },
  methods: {
    onSubmitRegister() {
      this.commentWriter = this.$store.state.resMember.username
      this.memberId = this.$store.state.resMember.id
        const {comment, memberId} = this
        this.$emit('submit', {comment, memberId})
    },
  }
}
</script>

<style scoped>

</style>