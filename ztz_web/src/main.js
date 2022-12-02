import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import vuetify from './plugins/vuetify'
import ButtonAmber from "@/components/common/ButtonAmber";
import ButtonWhite from "@/components/common/ButtonWhite";

Vue.config.productionTip = false


Vue.component('ButtonAmber', ButtonAmber)
Vue.component('ButtonWhite', ButtonWhite)

new Vue({
  router,
  store,
  vuetify,
  render: h => h(App)
}).$mount('#app')
