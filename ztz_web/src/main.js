import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import vuetify from './plugins/vuetify'

import CommonMainMenuTemplate from "@/components/header/Header";

 // 글로벌 컴포넌트
Vue.component('CommonMainMenuTemplate', CommonMainMenuTemplate)  // 글로벌 컴포넌트

Vue.config.productionTip = false

new Vue({
  router,
  store,
  vuetify,
  render: h => h(App)
}).$mount('#app')
