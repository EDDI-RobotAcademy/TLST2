<template>
  <div class="main-wrap">
    <div>
      <v-carousel
          cycle
          v-model="model"
          hide-delimiters
          max-height="500px">
        <v-carousel-item v-for="image in images" :key="image">
          <v-img :src="image" contain></v-img>
        </v-carousel-item>
      </v-carousel>
    </div>

    <div class="container">
      <div class="product">
        <main-page-product-list
            title="👍 오늘의 추천 ZTZ"
            :products="products"
        />
      </div>

      <div>
        <main-page-banner-form/>
      </div>

      <div class="product mt-10">
        <main-page-product-list
            title="💜 베스트 ZTZ"
            :products="bestProducts"
        />
      </div>
    </div>
  </div>
</template>

<script>
import {mapActions, mapState} from "vuex";
import MainPageProductList from "@/components/main/MainPageProductList";
import MainPageBannerForm from "@/components/main/MainPageBannerForm";

export default {
  name: "MainPageForm",
  components: {MainPageBannerForm, MainPageProductList},
  data() {
    return {
      cycle: true,
      interval: 1500,
      model: null,
      images: [
        require('@/assets/main/carouselImg/carousel_04.png'),
        require('@/assets/main/carouselImg/carousel_01.png'),
        require('@/assets/main/carouselImg/carousel_02.png'),
        require('@/assets/main/carouselImg/carousel_03.png'),
      ],
    }
  },
  methods: {
    ...mapActions([
      'reqProductsFromSpring',
      'reqBestProductsFromSpring'
    ]),
  },
  computed: {
    ...mapState([
      'products',
      'bestProducts'
    ])
  },
  mounted() {
    this.reqProductsFromSpring()
    this.reqBestProductsFromSpring()
  },
}
</script>

<style scoped>
.container {
  width: 1200px;
  margin: 0 auto;
  padding: 40px 0;
}


</style>