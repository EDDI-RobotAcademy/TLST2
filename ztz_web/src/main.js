import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import vuetify from './plugins/vuetify'
import ButtonGreen from "@/components/common/ButtonGreen";
import ButtonWhite from "@/components/common/ButtonWhite";
import VuePaginate from 'vue-paginate'

Vue.config.productionTip = false

import "@/css/products.css";
import "@/css/mypage.css";
import "@/css/foundry.css";
import MainHeader from "@/components/common/header/MainHeader";
import MainFooter from "@/components/common/footer/MainFooter";
import AddressForm from "@/components/common/AddressForm";

Vue.use(VuePaginate)
Vue.component('MainHeader', MainHeader)  // 글로벌 컴포넌트
Vue.component('MainFooter', MainFooter)
Vue.component('ButtonGreen', ButtonGreen)
Vue.component('ButtonWhite', ButtonWhite)
Vue.component('AddressForm', AddressForm)

new Vue({
  router,
  store,
  vuetify,
  render: h => h(App)
}).$mount('#app')
