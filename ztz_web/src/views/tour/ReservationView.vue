<template>
    <div class="wrap reservationView">
      <p class="menu-head-text">TOUR + EXPERIENCE</p>
      <p class="foundry-name">
        {{ this.item.name }}
      </p>
      <div class="program-info">
          <div class="program-head">
            <p class="head-text">양조장 프로그램 안내</p>
          </div>
  
          <div class="program-table">
            <ul class="strong-text">
              <li>프로그램 내용</li>
              <li>시간</li>
            </ul>
            <ul>
              <li>{{ this.item.content }}</li>
              <li>약 {{ this.item.durationOfTime }}시간</li>
            </ul>
            <ul class="strong-text">
              <li>최소 인원</li>
              <li>금액</li>
            </ul>
            <ul>
              <li>최소 {{ this.item.minMember }}명</li>
              <li>인당 {{ this.item.price }} won</li>
            </ul>
          </div>
        </div>
      <div id="map" class="map-area" style="width: 1200px; height: 300px; background-color: cyan;"></div>
    </div>
  </template>
    <!-- <script src="https://maps.googleapis.com/maps/api/js?key=<API KEY>"></script> -->
  <script>
  import "@/css/initialization.css";

  export default {
    name: "ReservationView",
    data(){
        return{
            item:{},
            map: null,
            location : { lat:'' , lng:'' },
        }
    },
    mounted(){
      // this.initMap()
      // this.setMarker(this.location, "<>")
    },
    created() {
        this.item = this.$store.state.selectedFoundry
        this.location.lat = this.item.mapPoint.lat
        this.location.lng = this.item.mapPoint.lng
    },
    methods: {
      // initMap() {
      //   this.map = new google.maps.Map(document.getElementById("map"), { //getElementById로 map id 속성의 요소를 가져온다.
      //     center: this.location, //center로 할 위도, 경도를 지정한다.
      //     zoom: 17, //zoom size를 지정.
      //     maxZoom: 20,
      //     minZoom: 3,
      //     streetViewControl: true,
      //     mapTypeControl: true,
      //     fuulscreenControl: true,
      //     zoomControl: true,
      //   });
      // },
      // setMarker(Points, Label) {//지도에 마커를 찍는 함수.
      //   const markers = new google.maps.Marker({
      //     position: Points,
      //     map: this.map,
      //     label: {
      //       text: Label,
      //       color: "#FFF",
      //     },
      //   });
      // },
    }
  }
  </script>