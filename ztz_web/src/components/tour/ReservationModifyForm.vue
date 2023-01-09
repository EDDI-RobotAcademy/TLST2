<template>
  <div class="reservationForm">
    <div>
      <p>{{ item.reservationId }}</p>
      <p>{{ foundryName }}</p>
    </div>
    <v-form @submit.prevent="onReservationSubmit" ref="form">
      <div class="reservation-style-box">
        <div>
          <label for="booker">성함</label>
          <input
            id="booker"
            type="text"
            v-model="booker"
            class="reservation-text-field"
            disabled
          />
        </div>

        <div>
          <label for="contactNumber">연락처</label>
          <input
            v-model="contactNumber"
            id="contactNumber"
            type="text"
            placeholder="-포함 핸드폰번호 11자리를 입력해주세요"
            class="reservation-text-field"
            required
          />
          <p v-show="valid.contactNumber" class="input-error">
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
    contactNumber: function () {
      this.checkContactNumber();
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
        contactNumber: false,
      },
      contactNumberHasError: false,

      booker: this.item.member.username,
      numberOfMember: this.item.numberOfMember,
      reservationDate: this.item.reservationDate,
      contactNumber: this.item.contactNumber,
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
        numberOfMember,
        reservationDate,
        phoneNumber,
        token,
      } = this;
      this.$emit("submit", {
        reservationId,
        foundryName,
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
    checkContactNumber() {
      const validateContactNumber = /^[0-9]+-[0-9]+-[0-9]{4}/;
      if (!validateContactNumber.test(this.contactNumber)) {
        this.valid.contactNumber = true;
        this.contactNumberHasError = true;
        return;
      }
      this.valid.contactNumber = false;
      this.contactNumberHasError = false;
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
