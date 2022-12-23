<template>
    <section class="profile-section">
        <div class="my-info-box">
            <div>
                <p class="name head-text">{{ this.$store.state.resMember.username }}</p>
                <p class="email">{{ this.$store.state.resMember.email }}</p>
            </div> 
            <button-white
              small
              width="64px"
              style="padding: 0 16px 0 10px; font-size: 13px;"
              btn-name="회원탈퇴"
              @click="withdrawal()"
            />
        </div>
        <ul>
            <li>
                <p class="head-text">
                    주문내역
                </p>
                <p class="content-text">
                    건
                </p>
            </li>
            <li>
                <p class="head-text">
                    리뷰내역
                </p>
                <p class="content-text">
                    건
                </p>
            </li>
            <li>
                <p class="head-text">
                    예약내역
                </p>
                <p class="content-text">
                    건
                </p>
            </li>
        </ul>

    </section>
  </template>
  
  <script>
  import { mapActions, mapState } from "vuex";
  export default {
    name: "MyPageProfileSection",
    computed: {
    ...mapState(["isAuthenticated", "resMember"]),
    },
    mounted() {
    if (this.$store.state.isAuthenticated === true) {
      let token = window.localStorage.getItem("userInfo");
      this.reqMemberInfoToSpring(token);
    } else {
      alert("로그인 상태가 아닙니다.");
    }
  },
  methods: {
    ...mapActions(["reqDeleteMemberToSpring", "reqMemberInfoToSpring"]),
    async withdrawal() {
      let withdrawalMessage = confirm("회원 탈퇴하시겠습니까?");

      if (withdrawalMessage) {
        let token = window.localStorage.getItem("userInfo");
        // eslint-disable-next-line no-undef
        await this.reqDeleteMemberToSpring(token);
        console.log(this.$store.state.resMyRequest.toString());
        this.$store.commit("IS_AUTHENTICATED", false);
        localStorage.removeItem("userInfo");
        this.$cookies.remove("user");
        alert("회원탈퇴가 완료되었습니다. 그동안 이용해주셔서 감사드립니다.");
        await this.$router.push({ name: "HomeView" });
      }
    },
  }
}
  </script>
  