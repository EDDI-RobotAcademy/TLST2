<template>

  <ul class="foundry-list-box">
    <li
      v-if="!foundrys || (Array.isArray(foundrys) && foundrys.length === 0)"
      class="empty_foundry"
    >
      <p>협력하는 양조장이 없습니다.</p>
    </li>
    <li
      v-else
      v-for="(foundry, idx) in foundrys"
      :key="idx"
      class="active-tab tab"
    >
      <div class="default-info">
        <p class="name">{{ foundry.name }}</p>
        <div class="contact-info">
          <p>
            <span
              ><v-icon small color="#205c37">mdi-map-marker</v-icon> 양조장
              주소지
            </span>
            | {{ foundry.address }}
          </p>
          <p>
            <span
              ><v-icon small color="#205c37">mdi-phone</v-icon> 전화번호
            </span>
            | {{ foundry.tel }}
          </p>
        </div>
      </div>
      <button v-on:click="goReservation(foundry)" v-show="activeConfirm">
        예약하기
      </button>
    </li>
  </ul>

</template>

<script>
import { mapState, mapActions } from "vuex";
export default {
  name: "FoundryList",
  props: {
    foundrys: {
      type: Array,
    },
  },
  computed: {
    ...mapState(["isAuthenticated","resMember"]),
  },
  mounted() {
    if (this.$store.state.isAuthenticated === true) {
      let token = window.localStorage.getItem("userInfo");
      this.reqMemberInfoToSpring(token);
      this.isLoggedIn = true;
      this.isManager = this.$store.state.resMember.managerCheck
      if(this.isLoggedIn === true && this.isManager === false) {
        this.activeConfirm = true
      }
    } else {
      alert("로그인이 필요합니다.")
    }
  },
  data() {
    return {
      show: false,
      isLoggedIn: false,
      isManager :false,
      activeConfirm : false,
    };
  },
  methods: {
    ...mapActions([
      "reqMemberInfoToSpring",
    ]),
    goReservation(foundry) {
      this.$store.commit("REQUEST_FOUNDRY_INFO", foundry);
      this.$router.push({ name: "ReservationView" });
    },
  },
};
</script>
