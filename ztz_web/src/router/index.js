import Vue from 'vue'
import VueRouter from 'vue-router'

import SignUpView from "@/views/account/SignUpView";
import SignInView from "@/views/account/SignInView";
import TestView from "@/views/TestView";
import ProductDetailView from "@/views/products/ProductDetailView";
import HomeView from "@/views/HomeView";
import KaramView from "@/views/KaramView";

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/karam-view',
    name: 'KaramView',
    component: KaramView
  },
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
  {
    // /:productNo
    path: '/product/detail',
    name: 'ProductDetailView',
    component: ProductDetailView
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
