<template>
  <div>
    <div class="title">
      <p>{{ title }}</p>
      <v-divider></v-divider>
    </div>
    <div class="product">
      <carousel :per-page="5" autoplay="true" loop="true" autoplay-timeout="3000">
        <slide v-for="(product, idx) in products.slice(0,15)" :key="idx">
          <router-link
              style="text-decoration: none"
              :to="{ name: 'ProductDetailView',
                                params: { productNo: product.productNo.toString() }}">
            <v-card width="200px" height="380px" elevation="0" style="margin: 10px" flat>
              <v-card-text style="padding: 10px 0 10px 0">
                <v-img
                    :src="require(`@/assets/products/uploadImg/${product.productInfo.thumbnailFileName}`)"
                    max-width="300px"
                    max-height="250px" contain/>
              </v-card-text>
              <div class="product-info">
                <p style="color: #568869; font-size: 12px">{{ product.brand }}</p>
                <p>{{ product.name }}</p>
                <p style="color: black; font-weight: bold"><span v-if="product.monthAlcoholCheck" style="color: red" >10% &nbsp; </span>{{ product.price | numberFormat }} 원</p>
              </div>
            </v-card>
          </router-link>
        </slide>
      </carousel>
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
  margin-top: 40px;
  font-size: 20px;
  font-weight: bold;
}

.product {
  margin-top: 20px;
}

.product .product-info {
  margin: 0 0 0 ;
}

.product .product-info p {
  margin: 3px;
  font-size: 14px;
}


</style>