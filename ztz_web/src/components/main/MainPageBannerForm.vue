<template>
  <div class="banner-collection">
    <div class="banner-box">
      <div class="flex-box">
        <div class="l">
          <div class="box l-box">
            <router-link :to="{ name: 'MonthDrinkView'}" style="text-decoration: none">
              <v-img
                  height="500px"
                  :src="require('@/assets/banner/banner_08.jpg')">
                <div class="text-box">
                  <p>12월의 이달의 시음주</p>
                  <div class="text">
                    <p style="margin-top: 10px">상품 보기</p>
                  </div>
                </div>
              </v-img>
            </router-link>
          </div>
        </div>
        <div class="r">
          <div class="box r-box">
            <router-link :to="{ name: 'FoundryView'}" style="text-decoration: none">
              <v-img
                  height="500px"
                  :src="require('@/assets/banner/banner_07.png')">
                <div class="text-box">
                  <p>양조장 예약 서비스</p>
                  <div class="text">
                    <p style="margin-top: 10px">더 알아보기</p>
                  </div>
                </div>
              </v-img>
            </router-link>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "MainPageBannerForm"
}
</script>

<style scoped>

.banner-collection {
  background-color: #f6f6f6;
  margin-top: 80px;
  padding: 80px 0;
}

.banner-box {
  max-width: 1040px;
  margin-left: auto;
  margin-right: auto;
  padding: 0 20px;
}

.flex-box {
  display: flex;
  justify-content: space-between;
}

.flex-box .l {
  flex: 0 0 50%;
  width: 50%;
}

.flex-box .box {
  position: relative;
  box-sizing: border-box;
}

.flex-box .r {
  flex: 0 0 48.33%;
  width: 48.33%;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.box p {
  font-weight: bold;
  font-size: 20px;
  color: #4d5450;
}
.box .text-box {
  margin: 80px 60px 0

}

.box .text-box .text {
  width: 121px;
  height: 52px;
  text-align: center;
  border-radius: 12px;
  border: 1px solid #4d5450;
}

</style>