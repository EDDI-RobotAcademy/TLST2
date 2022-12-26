<template>
  <div class="reservationForm">
    <div>
      <p>{{ item.reservationId }}</p>
      <p>{{ foundryName }}</p>
    </div>
    <v-form @submit.prevent="onReservationSubmit" ref="form">
      <div class="reservation-style-box">
        <div>
          <label for="username">성함</label>
          <input
            id="username"
            type="text"
            v-model="username"
            class="reservation-text-field"
            disabled
          />
        </div>

        <div>
          <label for="phoneNumber">연락처</label>
          <input
            v-model="phoneNumber"
            id="phoneNumber"
            type="text"
            placeholder="-포함 핸드폰번호 11자리를 입력해주세요"
            class="reservation-text-field"
            required
          />
          <p v-show="valid.phoneNumber" class="input-error">
            핸드폰번호를 정확히 입력해주세요.
          </p>
        </div>

        <div>
          <label for="reservationDate">예약일</label>

          <date-picker
            v-model="reservationDate"
            :disabled-date="disabledDate"
            valueType="format"
            class="date-picker-ui"
            required
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
            <p class="member">{{ numberOfMember }}</p>
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
        btn-name="예약수정"
      >
      </button-green>
    </v-form>
  </div>
</template>
<script>
import "@/css/initialization.css";
import DatePicker from "vue2-datepicker";
import "vue2-datepicker/index.css";
import { mapState } from "vuex";

export default {
  name: "ReservationModifyForm",
  components: { DatePicker },
  props: {
    item: {
      type: Object,
      required: true,
    },
  },
  watch: {
    phoneNumber: function () {
      this.checkPhoneNumber();
    },
  },
  computed: {
    ...mapState(["isAuthenticated", "resMember"]),
  },
  mounted() {
    if (this.$store.state.isAuthenticated === true) {
      this.token = window.localStorage.getItem("userInfo");
    } else {
      alert("로그인 상태가 아닙니다.");
    }
  },
  data() {
    return {
      valid: {
        phoneNumber: false,
      },
      phoneNumberHasError: false,

      username: this.item.username,
      numberOfMember: this.item.numberOfMember,
      reservationDate: this.item.reservationDate,
      phoneNumber: this.item.phoneNumber,
      token: "",
      foundryName: this.item.foundry.name,
      reservationId: this.item.reservationId,
    };
  },
  methods: {
    disabledDate(val) {
      return val <= new Date();
    },

    onReservationSubmit() {
      const {
        reservationId,
        foundryName,
        username,
        numberOfMember,
        reservationDate,
        phoneNumber,
        token,
      } = this;
      this.$emit("submit", {
        reservationId,
        foundryName,
        username,
        numberOfMember,
        reservationDate,
        phoneNumber,
        token,
      });
    },

    qtyDecrease() {
      if (this.numberOfMember > 0) {
        this.numberOfMember--;
      } else {
        this.numberOfMember = 0;
      }
    },
    qtyIncrease() {
      this.numberOfMember++;
    },
    checkPhoneNumber() {
      const validatePhoneNumber = /^[0-9]+-[0-9]+-[0-9]{4}/;
      if (!validatePhoneNumber.test(this.phoneNumber)) {
        this.valid.phoneNumber = true;
        this.phoneNumberHasError = true;
        return;
      }
      this.valid.phoneNumber = false;
      this.phoneNumberHasError = false;
    },
  },
};
</script>
<style>
.input-error {
  display: float;
  font-size: 11px;
  color: red;
}
</style>
