<template>
  <div class="wrap productWrap">
    <div class="list-filter-area">
      <v-list flat>
        <v-list-item-group
          v-model="selectedItem"
          color="#205C37"
          style="display: flex; font-weight: 500"
        >
          <v-list-item
            v-for="(local, index) in localMenu"
            :key="index"
            @click="acquireFilteredProducts(index)"
            style="padding: 0 0 0 20px"
          >
            <v-list-item-content>
              <v-list-item-title v-text="local"> </v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </div>

    <product-list :products="products"></product-list>
  </div>
</template>

<script>
import "@/css/initialization.css";
import ProductCard from "@/components/products/ProductCard.vue";
import ProductList from "@/components/products/ProductList.vue";

import { mapState, mapActions } from "vuex";

export default {
  name: "productListView",
  components: {
    // eslint-disable-next-line vue/no-unused-components
    ProductCard,
    ProductList,
  },
  data() {
    return {
      selectedItem: 1,
      localMenu: ["서울경기", "강원", "충청", "경상", "전라", "제주"],
    };
  },
  computed: {
    ...mapState(["products", "resMember"]),
  },
  mounted() {
    this.reqProductsFromSpring();
    if (this.$store.state.isAuthenticated === true) {
      let token = window.localStorage.getItem("userInfo");
      this.reqMemberInfoToSpring(token);
    }
    console.log("products");
  },
  methods: {
    ...mapActions([
      "reqProductsFromSpring",
      "reqFilteredProductsFromSpring",
      "reqMemberInfoToSpring",
    ]),
    async acquireFilteredProducts(index) {
      console.log("spring에서 아이템을 가져옵니다. : " + this.localMenu[index]);
      let localName = this.localMenu[index];
      await this.reqFilteredProductsFromSpring(localName);
    },
    allProduct() {
      this.reqProductsFromSpring();
    },
  },
};
</script>
