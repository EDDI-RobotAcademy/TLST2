<template>
  <div>
    <div class="title">
      <p>{{ title }}</p>
      <v-divider></v-divider>
    </div>
    <div class="product">
      <v-row>
        <v-col cols="2" v-for="(product, idx) in products" :key="idx">
          <router-link
              style="text-decoration: none"
              :to="{ name: 'ProductDetailView',
                                params: { productNo: product.productNo.toString() }}">
            <v-card width="200px" height="250px" elevation="1">
              <v-card-text style="padding: 10px 0 10px 0">
              <v-img
                  :src="require(`@/assets/products/uploadImg/${product.productInfo.thumbnailFileName}`)"
                  max-width="200px"
                  max-height="150px" contain/>
              </v-card-text>
              <div class="product-info">
                <p style="color: #568869; font-size: 12px">{{ product.brand }}</p>
                <p>{{ product.name }}</p>
                <p style="color: black; font-weight: bold">{{ product.price | numberFormat }} 원</p>
              </div>
            </v-card>
          </router-link>
        </v-col>
      </v-row>
    </div>
  </div>
</template>

<script>
export default {
  name: "MainPageProductList",
  props: {
    title: String,
    products: Array,
  },
}
</script>

<style scoped>

.title p {
  font-size: 20px;
  font-weight: bold;
}

.product {
  margin-top: 20px;
}
.product .product-info {
  margin: 0 0 0 20px;
}

.product .product-info p{
  margin: 3px;
  font-size: 14px;
}


</style>