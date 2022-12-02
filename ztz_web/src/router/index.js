import Vue from 'vue'
import VueRouter from 'vue-router'

import SignUpView from "@/views/account/SignUpView";
import SignInView from "@/views/account/SignInView";
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
  {
    path: '/sign-in',
    name: 'SignInView',
    component: SignInView
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
