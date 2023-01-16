<template>
  <div class="detailWrap">
    <product-detail-form class="mt-15"
                         :product="product"
                         @addCart="addCart"
                         @deleteProduct = "deleteProduct"
                         @saveFavorite = "saveFavorite"
                         :productFavoriteInfo = "productFavoriteInfo"
                         :reviewInfo = "reviewInfo"
    />
  </div>
</template>

<script>
import ProductDetailForm from "@/components/products/ProductDetailForm";
import {mapActions, mapState} from "vuex";

export default {
  name: "ProductDetailView",
  components: {ProductDetailForm},
  props: {
    productNo: {
      type: String,
      required: true
    }
  },
  computed: {
    ...mapState([
      'product', 'isAuthenticated', 'resMember', 'productFavoriteInfo', "reviewInfo"
    ])
  },
  async created(){
    await this.requestProductFromSpring(this.productNo)
    await this.reqProductReviewAvgFromSpring(this.productNo)
    if(this.isAuthenticated){
      let token = window.localStorage.getItem('userInfo')
      await this.reqMemberInfoToSpring(token)
      const memberId = this.$store.state.resMember.id
      const productNo = this.productNo
      const favoriteType = "favoriteCheck"
      await this.reqSaveFavoriteToSpring({memberId, productNo, favoriteType})
    }else {
      const memberId = null
      const productNo = this.productNo
      const favoriteType = "favoriteCheck"
      await this.reqSaveFavoriteToSpring({memberId, productNo, favoriteType})
    }
  },

  methods: {
    ...mapActions([
      'requestProductFromSpring',
      'reqAddCartToSpring',
      'reqMemberInfoToSpring',
      'reqCartListFromSpring',
      'requestDeleteProductToSpring',
      'reqSaveFavoriteToSpring',
      'reqProductReviewAvgFromSpring'
    ]),
    async addCart(payload){
      if(this.isAuthenticated){
        const {productNo, count} = payload
        let token = window.localStorage.getItem('userInfo')
        await this.reqMemberInfoToSpring(token)
        await this.reqAddCartToSpring({productNo, count, token})
        let cartMessage = confirm("장바구니에 상품을 담았습니다. 장바구니로 이동하시겠습니까?")
        if(cartMessage){
          await this.$router.push({name: 'CartView'})
        }
      } else {
        alert("로그인이 필요합니다.")
      }
    },
    async deleteProduct(payload){
      const productNo = payload
      await this.requestDeleteProductToSpring(productNo);
      await this.$router.push({ name: 'ProductsView' })
    },
    async saveFavorite(payload){
      let token = window.localStorage.getItem('userInfo')
      await this.reqMemberInfoToSpring(token)
      const memberId = this.$store.state.resMember.id
      const productNo = payload.productNo
      const favoriteType = "favoriteLike"
      console.log("상품페이지:" +memberId+productNo)
      await this.reqSaveFavoriteToSpring({memberId, productNo, favoriteType})
    }
  },

}
</script>

<style scoped>
.detailWrap {
  width: 1200px;
  margin: 0 auto;
  padding: 40px 0;
}

</style>