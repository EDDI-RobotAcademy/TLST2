<template>
  <div class="white" style="font-family: Arial">
    <v-row justify="center">
      <v-col cols="auto" style="padding-bottom: 90px">
        <router-link to="/">
          <v-img
            :src="require('@/assets/ztz_logo1.png')" width="180" class="mx-auto"/>
        </router-link>
        <v-card width="460">
          <v-card-text class="text-center px-12 py-16">
            <v-form @submit.prevent="onSubmit" ref="form">
              <div class="text-h4 font-weight-black mb-10">회원 가입</div>

              <div class="d-flex">
                <v-text-field v-model="email" label="이메일" @change="emailValidation"
                              :rules="email_rule" :disabled="false" required/>
                <button-white text large style="font-size: 13px"
                       class="mt-3 ml-5"
                       @click="checkDuplicateEmail"
                       :disabled="!emailPass"
                        btn-name="이메일 중복검사">
                </button-white>
              </div>

              <div class="d-flex">
                <v-text-field v-model="password" label="비밀번호" type="password"
                              :rules="password_rule" :disabled="false" required/>
              </div>

              <div class="d-flex">
                <v-text-field v-model="password_confirm" label="비밀번호 확인" type="password"
                              :rules="password_confirm_rule" :disabled="false" required/>
              </div>

              <div class="d-flex">
                <v-text-field v-model="username" label="사용자명" :disabled="false" required/>
              </div>

              <div class="d-flex">
                <v-text-field v-model="birthdate" label="생년월일" :disabled="false" :rules="birthdate_rule" required/>
              </div>

              <button-amber type="submit" block x-large
                     class="mt-6" :disabled="(emailPass) == false"
                      btn-name="가입하기">
              </button-amber>

            </v-form>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "SignUpForm",
  data () {
    return {
      email: "",
      password: "",
      password_confirm: "",

      username: "",
      birthdate: "",

      emailPass: false,

      email_rule: [
        v => !!v || '이메일을 입력해주세요.',
        v => {
          const replaceV = v.replace(/(\s*)/g, '')
          const pattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/
          return pattern.test(replaceV) || '이메일 형식을 입력하세요.'
        }
      ],
      password_rule: [
          v => this.state === 'ins' ? !!v || '패스워드는 필수 입력사항입니다.' : true,
          v => !(v && v.length >= 30) || '패스워드는 30자 이상 입력할 수 없습니다.',
      ],
      password_confirm_rule: [
        v => this.state === 'ins' ? !!v || '패스워드는 필수 입력사항입니다.' : true,
        v => !(v && v.length >= 30) || '패스워드는 30자 이상 입력할 수 없습니다.',
        v => v === this.password || '패스워드가 일치하지 않습니다.'
      ],
      birthdate_rule: [
        v => !!v || '생년월일을 입력해주세요.',
        v => {
          const replaceV = v.replace(/(\s*)/g, '')
          const pattern = /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/
          return pattern.test(replaceV) || '생년월일 형식을 입력하세요.'
        }
      ],
    }
  },
  methods: {
    onSubmit () {
      if (this.$refs.form.validate()) {
        const { email, password, username, birthdate } = this
        this.$emit("submit", {  email, password, username, birthdate })
      } else {
        alert('올바른 정보를 입력하세요!')
      }
    },
    emailValidation () {
      const emailValid = this.email.match(
          /^(([^<>()[\]\\.,;:\s@]+(\.[^<>()[\]\\.,;:\s@]+)*)|(.+))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      );

      if (emailValid) {
        this.emailPass = true
      }
    },
    checkDuplicateEmail () {
      const emailValid = this.email.match(
          /^(([^<>()[\]\\.,;:\s@]+(\.[^<>()[\]\\.,;:\s@]+)*)|(.+))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      );

      if (emailValid) {
        const {email} = this
        axios.post(`http://localhost:7777/ztz/member/check-email/${email}`)
            .then((res) => {
              if (res.data) {
                alert("사용 가능한 이메일입니다.")
                this.emailPass = true
              } else {
                alert("중복된 이메일입니다.")
                this.emailPass = false
              }
            })
      }
    },
  }
}
</script>

<style scoped>

</style>