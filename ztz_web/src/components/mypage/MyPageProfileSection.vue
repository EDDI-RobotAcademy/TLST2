<template>
  <section class="profile-section">

    <div class="management-box  first-box">
      <p class="name head-text">홍길동님</p>
      <p class="email">irigeori@josun.com</p>
    </div>

    <nav>
      <ul class="sub-nav">
        <li><a href="#">회원정보변경</a></li>
        <li><a href="#">배송지관리</a></li>
        <li><a href="#">주문관리</a></li>
        <li><a href="#">리뷰관리</a></li>
        <li><a href="#">예약관리</a></li>
        <li><a @click="withdrawal">회원탈퇴</a></li>
      </ul>
    </nav>

  </section>
</template>

<script>
import {mapActions} from "vuex";
export default {
  name: "MyPageProfileSection",
  methods : {
    ...mapActions([
        'reqDeleteMemberToSpring'
    ]),
    async withdrawal() {
      if(window.localStorage.getItem('userInfo') != null) {
        let token = window.localStorage.getItem('userInfo')
        console.log("내 토큰 : " + token)
        // eslint-disable-next-line no-undef
        await this.reqDeleteMemberToSpring(token)
      } else {
        alert("로그인 상태가 아닙니다.")
      }
    }
  }
}
</script>

<style scoped>

</style>