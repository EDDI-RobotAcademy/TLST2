<template>
  <div class="productCard">
    <div class="productInfo">
      <div class="thumb">
        <img
          :src="
            require(`../../assets/products/uploadImg/${product.productInfo.thumbnailFileName}`)
          "
        />
      </div>
      <p class="brand">{{ product.brand }}</p>
      <p class="productName">{{ product.name }}</p>
      <div class="price">
        <p>
          <span v-if="product.monthAlcoholCheck" style="color: red"
            >10% &nbsp; </span
          >{{ product.price | numberFormat }}원
        </p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "ProductCard",
  props: {
    product: {
      type: Object,
      required: true,
    },
  },
};
</script>
