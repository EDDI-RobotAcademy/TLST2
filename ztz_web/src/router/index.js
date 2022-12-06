import Vue from 'vue'
import VueRouter from 'vue-router'

import SignUpView from "@/views/account/SignUpView";
import SignInView from "@/views/account/SignInView";
import TestView from "@/views/TestView";
import ProductDetailView from "@/views/products/ProductDetailView";
import CartView from "@/views/order/CartView";
import ProductsView from "@/views/products/ProductsView";

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
  {
    // /:productNo
    path: '/product',
    name: 'ProductsView',
    component: ProductsView
  },

  {
    // /:productNo
    path: '/product/detail',
    name: 'ProductDetailView',
    component: ProductDetailView
  },

  {
    path: '/cart',
    name: 'CartView',
    component: CartView
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
