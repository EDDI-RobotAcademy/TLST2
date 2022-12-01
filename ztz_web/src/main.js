import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import vuetify from './plugins/vuetify'
import CommonButtonWhite from "@/components/common/CommonButtonWhite";
import CommonButtonBlack from "@/components/common/CommonButtonBlack";

Vue.config.productionTip = false


Vue.component('CommonButtonBlack', CommonButtonBlack)
Vue.component('CommonButtonWhite', CommonButtonWhite)

new Vue({
  router,
  store,
  vuetify,
  render: h => h(App)
}).$mount('#app')
