import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import vuetify from './plugins/vuetify'

import MainHeader from "@/components/common/header/MainHeader";
import MainFooter from "@/components/common/footer/MainFooter";

Vue.component('MainHeader', MainHeader)  // 글로벌 컴포넌트
Vue.component('MainFooter', MainFooter)

Vue.config.productionTip = false

new Vue({
  router,
  store,
  vuetify,
  render: h => h(App)
}).$mount('#app')
