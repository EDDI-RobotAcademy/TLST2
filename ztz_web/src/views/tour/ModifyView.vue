<template>
  <div class="wrap reservationView">
    <p class="menu-head-text">RESERVATION</p>
    <div class="announce-text-box">
      <p>
        방문하시고 싶은 양조장 변경은 예약 취소 후 새롭게 예약 부탁드립니다.
      </p>
      <p>
        선 결제하신 예약건에 대해서는 별도의 유선 연락 후 처리해드리고 있습니다.
      </p>
      <p>유선번호 02-000-0000으로 연락 부탁드립니다.</p>
    </div>

    <reservation-modify-form :item="item" @submit="onReservationModifySubmit" />
  </div>
</template>
<script>
import "@/css/initialization.css";
import ReservationModifyForm from "@/components/tour/ReservationModifyForm.vue";
import { mapActions, mapState } from "vuex";

export default {
  name: "ModifyView",
  components: { ReservationModifyForm },
  data() {
    return {
      item: {},
      res: "",
    };
  },
  computed: {
    ...mapState(["resMyRequest"]),
  },
  created() {
    this.item = this.$store.state.reservationInfo;
  },
  methods: {
    ...mapActions(["reqModifyReservation"]),

    async onReservationModifySubmit(payload) {
      await this.reqModifyReservation(payload);
      this.res = this.$store.state.resMyRequest;

      if (this.res === 1) {
        alert("성공적으로 예약이 수정되었습니다.");
        this.$router.push({ name: "MyPageView" });
      }
    },
  },
};
</script>
