import Vue from "vue"
import App from "./App.vue"
import router from "./router"
import store from "./store"
import vuetify from "./plugins/vuetify"
import ButtonGreen from "@/components/common/ButtonGreen"
import ButtonWhite from "@/components/common/ButtonWhite"
import VuePaginate from "vue-paginate"
import VueCarousel from 'vue-carousel';

Vue.config.productionTip = false

import "@/css/font.css";
import "@/css/products.css"
import "@/css/mypage.css"
import "@/css/foundry.css"
import MainHeader from "@/components/common/header/MainHeader"
import NewFooter from "@/components/common/footer/footer.vue"
import AddressForm from "@/components/common/AddressForm"

Vue.filter('numberFormat', function (val) {
  return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
})
Vue.filter('nameFormat', function (val) {
  return String(val).replace(/.(?=.$)/u, "*");
})
Vue.use(VueCarousel)
Vue.use(VuePaginate)
Vue.component('MainHeader', MainHeader)
Vue.component("NewFooter", NewFooter)
Vue.component('ButtonGreen', ButtonGreen)
Vue.component('ButtonWhite', ButtonWhite)
Vue.component('AddressForm', AddressForm)

new Vue({
  router,
  store,
  vuetify,
  render: (h) => h(App),
}).$mount("#app")
