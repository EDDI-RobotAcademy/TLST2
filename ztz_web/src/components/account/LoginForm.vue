<template>
  <div class="white" style="font-family: Arial">
    <v-row justify="center" class="mt-6">
      <v-col cols="auto" style="padding-bottom: 90px">
        <v-card width="460" elevation="0">
          <v-card-text class="text-center px-12 py-16">
            <v-form @submit.prevent="onSubmit">
              <div class="text-h4 font-weight-black mb-10">로그인</div>

              <div class="d-flex">
                <v-text-field v-model="email" label="이메일" @change="emailValidation" color="black"
                              :rules="email_rule" clearable prepend-inner-icon="mdi-account-outline" outlined/>
              </div>

              <div class="d-flex">
                <v-text-field v-model="password" label="비밀번호" type="password" color="black"
                              :rules="password_rule" clearable prepend-inner-icon="mdi-lock-outline" outlined/>
              </div>

              <div>
                <button-green type="submit" block x-large
                              class="mt-4"  :disabled="false"
                              btn-name="로그인">
                </button-green>
              </div>
              <div>
                <button-white block x-large @click="goSignUp"
                              class="mt-4 ml-0" btn-name="회원가입">
                </button-white>
              </div>
            </v-form>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </div>
</template>

<script>

export default {
  name: "LoginForm",
  data () {
    return {
      email: "",
      password: "",
      email_rule: [
        v => !!v || '이메일을 입력해주세요.',
        v => {
          const replaceV = v.replace(/(\s*)/g, '')
          const pattern = /^(([^<>()[\]\\.,;:\s@]+(\.[^<>()[\]\\.,;:\s@]+)*)|(.+))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
          return pattern.test(replaceV) || '이메일 형식을 입력하세요.'
        }
      ],
      password_rule: [
        v => this.state === 'ins' ? !!v || '패스워드는 필수 입력사항입니다.' : true,
        v => !(v && v.length >= 30) || '패스워드는 30자 이상 입력할 수 없습니다.',
      ],
    }
  },
  methods: {
    onSubmit () {
      const { email, password } = this
      this.$emit("submit", { email, password })
    },
    goSignUp() {
      this.$router.push({ name: "SignUpView" });
    },
  }
}
</script>

<style scoped>

</style>