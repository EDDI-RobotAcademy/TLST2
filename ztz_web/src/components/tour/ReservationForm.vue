<template>
  <div class="reservationForm">
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
        :disabled="!isActive"
        btn-name="예약하기"
        @change="checkValidation"
      >
      </button-green>
    </v-form>
  </div>
</template>
<script>
import "@/css/initialization.css";
import DatePicker from "vue2-datepicker";
import "vue2-datepicker/index.css";
import { mapActions, mapState } from "vuex";

export default {
  name: "ReservationForm",
  components: { DatePicker },
  props: {
    item: {
      type: Object,
      required: true,
    },
  },
  beforeUpdate() {
    this.checkValidation();
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
      this.reqMemberInfoToSpring(this.token);
      console.log(this.token);
      this.username = this.$store.state.resMember.username;
      this.numberOfMember = this.item.minMember;
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

      username: "",
      numberOfMember: "",
      reservationDate: "",
      phoneNumber: "",
      isActive: false,
      token: "",
      foundryName: this.item.name,
    };
  },
  methods: {
    ...mapActions(["reqMemberInfoToSpring"]),
    disabledDate(val) {
      return val <= new Date();
    },
    checkIsEmpty(event) {
      if (event.target.value.length === 0) {
        alert("필수 값입니다.");
      }
    },
    checkValidation() {
      if (this.phoneNumber.length != 0 && this.reservationDate.length != 0) {
        this.isActive = true;
      }
    },
    onReservationSubmit() {
      const {
        foundryName,
        username,
        numberOfMember,
        reservationDate,
        phoneNumber,
        token,
      } = this;
      this.$emit("submit", {
        foundryName,
        username,
        numberOfMember,
        reservationDate,
        phoneNumber,
        token,
      });
    },
    qtyDecrease() {
      if (this.numberOfMember > this.item.minMember) {
        this.numberOfMember--;
      } else {
        this.numberOfMember = this.item.minMember;
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
