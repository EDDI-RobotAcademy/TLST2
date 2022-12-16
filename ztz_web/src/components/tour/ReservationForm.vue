<template>
  <div class="reservationForm">
    <v-form @submit.prevent="onReservationSubmit">
      <div class="reservation-style-box">

        <div>
          <label for="name">성함</label>
          <input
            id="name"
            type="text"
            v-model="name"
            class="reservation-text-field"
            disabled
          />
        </div>

        <div>
          <label for="phone">연락처</label>
          <input
            v-model="phone"
            id="phone"
            type="text"
            placeholder="연락처를 입력해주세요"
            class="reservation-text-field"
            @blur="checkIsEmpty($event)"
          />
        </div>

        <div>
          <label for="date">예약일</label>
          <input
            v-model="date"
            id="date"
            type="text"
            placeholder="예약일을 입력해주세요"
            class="reservation-text-field"
            @blur="checkIsEmpty($event)"
          />
        </div>

        <div>
          <label>예약인원</label>
          <div>
            <v-btn
              class="mr-5"
              elevation="0"
              color="white"
              @click="qtyDecrease"
              >
              <v-icon>mdi-minus</v-icon>
              </v-btn>
              <p class="member">{{ member }}</p>
              <v-btn
              class="ml-5"
              elevation="0"
              color="white"
              @click="qtyIncrease"
              >
              <v-icon>mdi-plus</v-icon>
            </v-btn>
          </div>
        </div>

      </div>

      <button-green
        type="submit"
        block
        x-large
        class="mt-6"
        :disabled="!isActive"
        btn-name="예약하기"
        @click="onReservationSubmit"
        @change="checkValidation"
      >
      </button-green>
    </v-form>
  </div>
</template>
<script>
import "@/css/initialization.css";
import { mapActions, mapState } from "vuex";

export default {
  name: "ReservationForm",
  beforeUpdate() {
    this.onReservationSubmit();
    this.checkValidation();
  },
  computed: {
    ...mapState(["isAuthenticated", "resMember"]),
  },
  mounted() {
    if (this.$store.state.isAuthenticated === true) {
      let token = window.localStorage.getItem("userInfo");
      this.reqMemberInfoToSpring(token);
      this.name = this.$store.state.resMember.username;
    } else {
      console.log(
        "내 상태가 로그인상태가 아니라면 자동으로 로그인창으로 넘어갈수 있나?"
      );
      alert("로그인 상태가 아닙니다.");
    }
  },
  data() {
    return {
      name: "",
      member: 1,
      date: "",
      phone: "",
      isActive: false,
    };
  },
  methods: {
    ...mapActions(["reqMemberInfoToSpring"]),
    checkIsEmpty(event) {
      if (event.target.value.length === 0) {
        alert("필수 값입니다.");
      }
    },
    checkValidation() {
      if (this.phone.length != 0 && this.date.length != 0) {
        this.isActive = true;
      }
    },
    onReservationSubmit() {
      const { name, member, date, phone } = this;
      this.$emit("submit", { name, member, date, phone });
    },
    qtyDecrease() {
      if (this.member > 0) {
        this.member--;
      } else {
        this.member = 0;
      }
    },
    qtyIncrease() {
      this.member++;
    },
  },
};
</script>
