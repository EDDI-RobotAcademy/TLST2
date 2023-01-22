<template>
  <div class="mt-5 ml-5">
    <div class="white" style="font-family: Arial">
      <v-row justify="center">
        <v-col cols="auto" style="padding-bottom: 90px">
          <v-card width="520" elevation="0">
            <v-card-text class="text-center px-12 py-16">
              <v-form @submit.prevent="onSubmit" ref="form">
                <div class="text-h4 font-weight-black mb-10">회원정보변경</div>
                <v-divider class="mb-8" style="border-width: 1px; border-color: black"></v-divider>
                <div>
                  <div class="d-flex" v-if="this.$store.state.resMember.managerCheck">
                    <v-text-field v-model="manager_code" label="관리자 코드 입력" type="password" outlined color="black"
                               :disabled="false" required/>
                  </div>

                  <div class="d-flex">
                    <v-text-field v-model="present_password" label="현재 비밀번호 입력" type="password" outlined color="black"
                                  :rules="password_rule" :disabled="false" required/>
                  </div>

                  <div class="d-flex">
                    <v-text-field v-model="new_password" label="새 비밀번호" type="password" outlined color="black"
                                  :rules="new_password_rule" :disabled="false" required/>
                  </div>

                  <div class="d-flex">
                    <v-text-field v-model="new_password_confirm" label="새 비밀번호 확인" type="password" outlined color="black"
                                  :rules="new_password_confirm_rule" :disabled="false" required/>
                  </div>

                  <div class="d-flex">
                    <v-text-field v-model="phoneNumber" :disabled="false"
                                  :rules="phoneNumber_rule" required outlined color="black"/>
                  </div>

                  <button-green
                      type="submit"
                      block
                      x-large
                      style="height: 55px"
                      :disabled="(emailPass) == false"
                      @click = "modifyMemberProfile"
                      btn-name="변경">
                  </button-green>
                </div>
              </v-form>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </div>
  </div>
</template>

<script>
import {mapActions, mapState} from "vuex";

export default {
  name: "MyPageProfileModify",

  data() {
    return {
//      phoneNumber: this.$store.state.resMember.managerCheck ? this.$store.state.managerPhoneNumber : this.$store.state.resMemberProfile.phoneNumber, // 중요!!!!!
      phoneNumber: "",
      manager_code: "",
      present_password: "",
      new_password: "",
      new_password_confirm: "",
      memberId: "",

      manager: false,
      password_rule: [
              v => this.state === 'ins' ? !!v || '패스워드는 필수 입력사항입니다.' : true,
              v => !(v && v.length >= 30) || '패스워드는 30자 이상 입력할 수 없습니다.',
            ],
      new_password_rule: [
        v => this.state === 'ins' ? !!v || '패스워드는 필수 입력사항입니다.' : true,
        v => !(v && v.length >= 30) || '패스워드는 30자 이상 입력할 수 없습니다.',
      ],
      new_password_confirm_rule: [
        v => this.state === 'ins' ? !!v || '패스워드는 필수 입력사항입니다.' : true,
        v => !(v && v.length >= 30) || '패스워드는 30자 이상 입력할 수 없습니다.',
        v => v === this.new_password || '패스워드가 일치하지 않습니다.'
      ],
      phoneNumber_rule: [
        v => !!v || '전화번호를 입력 해주세요.',
        v => {
          const replaceV = v.replace(/(\s*)/g, '')
          const pattern = /010-\d{4}-\d{4}/
          return pattern.test(replaceV) || '전화번호 11자리를 입력해주세요. ("-"포함)'
        }
      ]
    }
  },
  computed: {
    ...mapState([
      'isAuthenticated', 'resMember', 'resMemberProfile', 'managerPhoneNumber'
    ])
  },
  async mounted() {
    if (this.$store.state.isAuthenticated === true) {
      let token = window.localStorage.getItem('userInfo')
      await this.reqMemberInfoToSpring(token);
      if (this.$store.state.resMember.managerCheck === true) {
        await this.reqManagerProfileInfoToSpring(token);
        this.phoneNumber = this.$store.state.managerPhoneNumber;
      } else {
        await this.reqMemberProfileInfoToSpring(token);
        this.phoneNumber = this.$store.state.resMemberProfile.phoneNumber;
       }
    } else {
      alert("로그인 상태가 아닙니다.")
    }
  },
  methods: {
    ...mapActions([
      'reqMyPageProfileModifyFromSpring', 'reqMemberInfoToSpring', 'reqMemberProfileInfoToSpring', 'reqManagerProfileInfoToSpring',
    ]),
    async modifyMemberProfile() {
    const managerCheck = this.$store.state.resMember.managerCheck
    const memberId = this.$store.state.resMember.id;
    const phoneNumber = this.phoneNumber;
    const manager_code = this.manager_code;
    const present_password = this.present_password;
    const new_password = this.new_password;
    console.log("멤버 id 확인" + memberId);
    await this.reqMyPageProfileModifyFromSpring({ managerCheck, phoneNumber, manager_code, present_password, new_password, memberId })
    await this.$router.go(0)
    await this.$router.push("/my-page") // 변경 완료하고 바로 마이페이지로 이동!

    }
  }
}
</script>

<style scoped>

</style>