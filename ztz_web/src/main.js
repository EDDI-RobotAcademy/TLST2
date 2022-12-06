import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import vuetify from './plugins/vuetify'
import ButtonGreen from "@/components/common/ButtonGreen";
import ButtonWhite from "@/components/common/ButtonWhite";

Vue.config.productionTip = false

import "@/css/products.css";
Vue.component('ButtonGreen', ButtonGreen)
Vue.component('ButtonWhite', ButtonWhite)

new Vue({
  router,
  store,
  vuetify,
  render: h => h(App)
}).$mount('#app')
