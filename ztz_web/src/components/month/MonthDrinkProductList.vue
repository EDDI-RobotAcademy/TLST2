<template>
  <div>
    <div class="month-items">
      <div class="item-title">
        <div>
          <span>전체 상품 {{ products.length }}개</span>
        </div>
      </div>
      <v-divider style="border-width: 1px; border-color: black"></v-divider>
      <div class="item">
        <div>
          <v-row>
            <v-col cols="3" v-for="(product, idx) in products" :key="idx">
              <router-link
                  style="text-decoration: none"
                  :to="{ name: 'ProductDetailView',
                                params: { productNo: product.productNo.toString() }}">
                <v-card width="300px" height="350px">
                  <v-card-text style="padding: 20px 0 0 0">
                  <v-img
                      :src="require(`@/assets/products/uploadImg/${product.productInfo.thumbnailFileName}`)"
                      max-width="280px"
                      max-height="220px"
                      contain/>
                  </v-card-text>
                  <div class="item-info">
                    <p style="color: #568869; font-size: 14px">{{ product.brand }}</p>
                    <p>{{ product.name }}</p>
                    <p style="font-weight: bold">{{ product.price | numberFormat }} 원</p>
                  </div>
                </v-card>
              </router-link>
            </v-col>
          </v-row>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "MonthDrinkProductList",
  props: {
    products: Array
  },
}
</script>

<style scoped>

.month-items {
  margin-top: 30px;
}
.month-items .item-title {
  display: flex;
  justify-content: space-between;
  margin-bottom: 10px;
}

.month-items .item {
  margin-top: 30px;
}

.item .item-info {
  margin: 15px 0 0 20px;
}

.item .item-info p {
  margin: 6px;
}


</style>