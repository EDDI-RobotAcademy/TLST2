<template>
  <div>
    <div class="attention-box">
      <p>
        양조장 예약은 양조장의 사정으로 인해 취소 될 수 있으며, 양조장에서 개별
        연락이 갈 수 있습니다. 양조장 프로그램은 우천이나 인원, 안전 등의 이유로
        변경 될 수 있음을 안내드립니다.
      </p>
      <p>
        본 사이트에서 안내한 금액은 ZTZ와의 협의에 의한 금액으로 선결제 시
        해당하는 금액입니다. 방문 결제 시 금액은 변경될 수 있습니다.
      </p>
      <p>이 외 프로그램 관련 문의사항은 해당 양조장으로 문의 부탁드립니다.</p>
    </div>

    <ul class="my-reservation-list">
      <li v-for="(reservation, i) in myReservationList" :key="i">
        <v-card class="reservation-card mt-10">
          <v-toolbar flat color="#205c37" dark class="px-2"
            >예약코드 {{ reservation.reservationId }}</v-toolbar
          >
          <v-card-title>
            <v-row
              class="pt-4 px-5 mb-2"
              justify="space-between"
              style="border-bottom: 1px solid #ddd"
            >
              <p>
                예약자 <v-icon color="#ddd">mdi-drag-vertical-variant</v-icon>
                {{ reservation.username }}
              </p>
              <p>
                예약일 <v-icon color="#ddd">mdi-drag-vertical-variant</v-icon>
                {{ reservation.reservationDate }}
              </p>
            </v-row>
          </v-card-title>

          <div class="px-6">
            <p>
              연락처 <span class="mx-2" color="#ddd"> | </span
              >{{ reservation.phoneNumber }}
            </p>
            <p>
              예약인원 <span class="mx-2" color="#ddd"> | </span
              >{{ reservation.numberOfMember }}
            </p>
            <p>
              양조장 <span class="mx-2" color="#ddd"> | </span
              >{{ reservation.foundry.name }}
            </p>
            <p>결제상태 <span class="mx-2" color="#ddd"> | </span>n</p>
          </div>

          <div class="pl-5 pr-6 pb-6">
            <button-white
              medium
              width="86px"
              style="padding: 0 16px 0 10px"
              btn-name="선결제"
            />
            <div>
              <button-white
                medium
                width="86px"
                style="padding: 0 16px 0 10px"
                btn-name="예약취소"
              />
              <button-green
                medium
                width="86px"
                style="padding: 0 16px 0 10px"
                btn-name="예약수정"
              />
            </div>
          </div>
        </v-card>
      </li>
    </ul>
  </div>
</template>

<script>
import "@/css/initialization.css";
import { mapActions, mapState } from "vuex";

export default {
  name: "MyReservationDetail",
  computed: {
    ...mapState(["myReservationList"]),
  },
  mounted() {
    if (this.$store.state.isAuthenticated === true) {
      let token = window.localStorage.getItem("userInfo");
      this.reqMyReservationListToSpring(token);
    } else {
      alert("로그인 상태가 아닙니다.");
    }
  },
  methods: {
    ...mapActions(["reqMyReservationListToSpring"]),
  },
};
</script>
