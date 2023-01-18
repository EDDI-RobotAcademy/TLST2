<template>
  <div class="mt-10 ml-5">
    <div>
      <div class="head-area">
        <div align="right" class="mr-3 mb-3">총 {{ this.$store.state.myFavoriteList.length }} 건</div>
      </div>
    </div>
    <v-divider></v-divider>
<!--찜 상품 리스트-->
    <div class="item-info" v-if="!myFavoriteList || (Array.isArray(myFavoriteList) && myFavoriteList.length === 0)">
        <p align="center" class="mt-15 mb-15"> 찜한 상품이 없습니다.</p>
      <v-divider></v-divider>
    </div>
    <div v-else>
    <div class="item-info" v-for="(item, index) in myFavoriteList" :key="index">
      <div class="l">
          <v-row>
              <v-img class="ml-1"
                  :src="require(`@/assets/products/uploadImg/${item.product.productInfo.thumbnailFileName}`)"
                  max-width="200"
                  max-height="150"
                  contain
              />
            <div class="c1">
              <p class="item-name" @click="productViewBtn(item)">{{ item.product.name }}</p>
              <p class="item-description" @click="productViewBtn(item)">{{ item.product.brand }}</p>
            </div>
            <div class="r1">
              <p>{{ item.product.price | numberFormat }} 원</p>
            </div>
            <div class="r2">
              <v-col>
                <ButtonGreen class="ml-0 ma-2"
                             @click="addCart(item.product.productNo)"
                             btn-name="장바구니"
                />
                <ButtonWhite
                             @click="cancelFavorite(item.product.productNo)"
                             btn-name="찜 삭제"
                />
              </v-col>
            </div>

          </v-row>

        </div>
      <v-divider></v-divider>
    </div>
    </div>
<!--    찜리스트 끝-->

  </div>
</template>

<script>

import {mapState, mapActions} from "vuex";

export default {
  name: "MYFavoriteForm",
  data() {
    return {

    }
  },
  mounted() {
      let token = window.localStorage.getItem("userInfo");
      this.reqMyFavoriteListToSpring(token);
  },
  computed: {
    ...mapState([
      'myFavoriteList','resMember'
    ]),
  },
    methods: {
      ...mapActions([
        'reqMyFavoriteListToSpring', 'reqAddCartToSpring', 'reqMemberInfoToSpring', 'reqSaveFavoriteToSpring'
      ]),
      async addCart(payload){
        console.log("장바구니 찜에서 담기")
          const productNo = payload
          const count = 1
          let token = window.localStorage.getItem('userInfo')
          await this.reqMemberInfoToSpring(token)
          await this.reqAddCartToSpring({productNo, count, token})
          let cartMessage = confirm("장바구니에 상품을 담았습니다. 장바구니로 이동하시겠습니까?")
          if(cartMessage){
            await this.$router.push({name: 'CartView'})
          }
      },

      async cancelFavorite(payload){
        let token = window.localStorage.getItem('userInfo')
        await this.reqMemberInfoToSpring(token)
        const memberId = this.$store.state.resMember.id
        const productNo = payload
        const favoriteType = "favoriteLike"
        await this.reqSaveFavoriteToSpring({memberId, productNo, favoriteType })
        alert("찜상품을 삭제하였습니다.")
        await this.$router.go(this.$router.currentRoute)
      },

      productViewBtn(item) {
        alert("상품 상세페이지로 이동합니다.")
        this.$router.push({name: 'ProductDetailView', params: {productNo: item.product.productNo}})
      }
  },

    //가격 ,000 원단위 포맷으로 가공
    filters: {
      numberFormat(val) {
        return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
      }
    },

}
</script>

<style scoped>

.item-info .l {
  position: relative;
  margin-top: 30px;
  margin-bottom: 30px;
  margin-left: 0%;

}
.item-info .c1{
  position: relative;
  margin-top: 40px;
  margin-left: 5%;
  width: 200px;
}

.item-info .r1 {
  position: relative;
  margin-top: 60px;
  margin-left: 15%;
}
.item-info .r2 {
  position: relative;
  margin-top: 40px;
  margin-left: 10%;
}


</style>