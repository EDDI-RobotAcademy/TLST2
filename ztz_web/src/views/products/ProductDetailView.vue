<template>
  <div class="detailWrap">
    <product-detail-form class="mt-15"
                         :product="product"
                         @addCart="addCart"
                         @deleteProduct = "deleteProduct"
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
      'product', 'isAuthenticated', 'resMember'
    ])
  },
  created() {
    this.requestProductFromSpring(this.productNo)
  },

  methods: {
    ...mapActions([
        'requestProductFromSpring', 'reqAddCartToSpring', 'reqMemberInfoToSpring', 'reqCartListFromSpring', 'requestDeleteProductToSpring'
    ]),
    async addCart(payload){
      if(this.isAuthenticated){
        const {productId, count} = payload
        let token = window.localStorage.getItem('userInfo')
        await this.reqMemberInfoToSpring(token)
        const memberId = this.resMember.id

        await this.reqAddCartToSpring({memberId, productId, count})
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