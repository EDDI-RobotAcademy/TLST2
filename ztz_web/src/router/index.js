import Vue from 'vue'
import VueRouter from 'vue-router'

import SignUpView from "@/views/account/SignUpView";
import TestView from "@/views/TestView";

Vue.use(VueRouter)

const routes = [
  {
    path: '/test',
    name: 'test',
    component: TestView
  },
  {
    path: '/sign-up',
    name: 'SignUpView',
    component: SignUpView
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
