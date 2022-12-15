<template>
    <div class="foundry-info-card">
      <p v-on:click="toggle()" class="foundry-name">
        {{ foundry.name }}
        <span class="opened-tab" v-show="this.show"><v-icon large color="#222">mdi-chevron-up</v-icon></span>
        <span class="closed-tab" v-show="!this.show"><v-icon large color="#222">mdi-chevron-down</v-icon></span>
      </p>
  
      <div v-if="show" class="foundry-detail">
        <div class="default-info">
          <p>
            <span><v-icon small color="#205c37">mdi-map-marker</v-icon> 양조장 주소지 </span>
            | {{ foundry.address }}
          </p>
          <p><span><v-icon small color="#205c37">mdi-phone</v-icon> 전화번호 </span>
            | {{ foundry.tel }}
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
              <li>프로그램 내용</li>
              <li>시간</li>

            </ul>
            <ul>
              <li>{{ foundry.content }}</li>
              <li>{{ foundry.durationOfTime }}</li>
            </ul>
            <ul class="strong-text">
              <li>최소 인원</li>
              <li>금액</li>
            </ul>
            <ul>
              <li>{{ foundry.minMember }} 명</li>
              <li>인당 {{ foundry.price }}  won</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </template>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDsmRcOokFJn74RHnY12uUg13g0o-op6mo"></script>
  <script>
  import {mapState} from "vuex";
  
  export default {
    name: "FoundryCard",
    props: {
      foundry: {
        type: Object,
        required: true,
      }
    },
    computed: {
      ...mapState([
        'isAuthenticated',
      ]),
    },
    mounted() {
      if (this.$store.state.isAuthenticated === true) {
          console.log("로그인 상태")
          this.isLoggedIn = true
      } else {
          console.log("로그인 필요")
      }
    },
    data() {
      return {
        show: false,
        isLoggedIn: false,
        map: null,
        location : { lat: this.foundry.mapPoint.lat, lng:this.foundry.mapPoint.lng },
      };
    },
    methods: {
      toggle() {
        this.show = !this.show
        if(this.show === true) {
          this.initMap()
          this.setMarker()
        }
      },
      initMap() {
      this.map = new google.maps.Map(document.getElementById("map"), { //getElementById로 map id 속성의 요소를 가져온다.
        center: this.location, //center로 할 위도, 경도를 지정한다.
        zoom: 17, //zoom size를 지정.
        maxZoom: 20,
        minZoom: 3,
        streetViewControl: true,
        mapTypeControl: true,
        fuulscreenControl: true,
        zoomControl: true,
      });
    },
    setMarker(Points, Label) {//지도에 마커를 찍는 함수.
      const markers = new google.maps.Marker({
        position: Points,
        map: this.map,
        label: {
          text: Label,
          color: "#FFF",
        },
      });
    },
    },
  }
  </script>
  