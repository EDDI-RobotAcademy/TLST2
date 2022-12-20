<template>
  <div class="wrap">
    <p class="menu-head-text">Reservation Complete</p>
    <div class="img-reservation">
      <img src="@/assets/tour/illust.png" alt="예약성공" />
    </div>
    <complete-reservation-card :myReservationInfo="myReservationInfo" />
  </div>
</template>
<script>
import "@/css/initialization.css";
import CompleteReservationCard from "@/components/tour/CompleteReservationCard.vue";

export default {
  name: "CompleteView",
  components: { CompleteReservationCard },
  data() {
    return {
      myReservationInfo: {},
    };
  },
  created() {
    this.myReservationInfo = this.$store.state.reservationInfo;
    console.log(this.$store.state.reservationInfo);
    console.log(this.myReservationInfo);
  },
};
</script>
