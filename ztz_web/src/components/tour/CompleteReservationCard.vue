<template>
  <div class="infoCard">
    <p>예약을 성공하였습니다.</p>
    <ul class="completeList">
      <li><span>예약자 </span> : {{ myReservationInfo.username }}</li>
      <li><span>연락처 </span> : {{ myReservationInfo.phoneNumber }}</li>
      <li><span>예약한 양조장 </span> : {{ myReservationInfo.foundryName }}</li>
      <li><span>예약일 </span> : {{ myReservationInfo.reservationDate }}</li>
      <li><span>예약인원 </span> : {{ myReservationInfo.numberOfMember }}</li>
    </ul>
    <div class="button-box">
      <button-white large width="200px" btn-name="메인으로" @click="goHome()">
      </button-white>
      <button-green
        large
        width="200px"
        btn-name="마이페이지"
        @click="goMypage()"
      >
      </button-green>
    </div>
  </div>
</template>

<script>
export default {
  name: "CompleteReservationCard",
  props: {
    myReservationInfo: {
      type: Object,
      required: true,
    },
  },
  methods: {
    goHome() {
      this.$router.push({ name: "home" });
    },
    goMypage() {
      this.$router.push({ name: "MyPageView" });
    },
  },
};
</script>
