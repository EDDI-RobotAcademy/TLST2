<template>
  <div class="foundry-info-card">
    <p v-on:click="toggle()" class="foundry-name">
      산좋고 물좋고 술도좋고
      <span class="opened-tab" v-show="this.show"><v-icon large color="#222">mdi-chevron-up</v-icon></span>
      <span class="closed-tab" v-show="!this.show"><v-icon large color="#222">mdi-chevron-down</v-icon></span>
    </p>

    <div v-if="show" class="foundry-detail">
      <div class="default-info">
        <p>
          <span><v-icon small color="#205c37">mdi-map-marker</v-icon> 양조장 주소지 </span>
          | 여기가 어딘지 나도모르겠구 신주소로 559길
        </p>
        <p><span><v-icon small color="#205c37">mdi-phone</v-icon> 전화번호 </span>
          | 0505-000-0505
        </p>
      </div>

      <div id="map" class="map-area">여기 지도 들어옴.</div>

      <div class="program-info">
        <div class="program-head">
          <p class="head-text">양조장 프로그램 안내</p>
          <button v-show="isLoggedIn">예약하기</button>
        </div>

        <div class="program-table">
          <ul class="strong-text">
            <li>프로그램 명</li>
            <li>시간</li>
            <li>프로그램 내용</li>
          </ul>
          <ul>
            <li>양조장 방문 및 시음 프로그램</li>
            <li>3시간</li>
            <li>양조장 내부 투어 및 2종 주류 시음</li>
          </ul>
          <ul class="strong-text">
            <li>최소 인원</li>
            <li>금액</li>
          </ul>
          <ul>
            <li>2명</li>
            <li>인당 30,000 won</li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {mapState} from "vuex";

export default {
  name: "FoundryCard",
  computed : {
    ...mapState([
      'isAuthenticated',
    ])
  },
  mounted() {
    if(this.$store.state.isAuthenticated === true){
      console.log("로그인 상태")
      this.isLoggedIn = true
    } else {
      console.log("로그인 필요")
    }
  },
  methods: {
    toggle() {
      this.show = !this.show
    }
  },
  data() {
    return {
      show: true,
      isLoggedIn : false,
    };
  },
}
</script>