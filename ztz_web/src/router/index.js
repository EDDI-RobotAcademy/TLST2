import Vue from 'vue'
import VueRouter from 'vue-router'

import SignUpView from "@/views/account/SignUpView";
import SignInView from "@/views/account/SignInView";
import TestView from "@/views/TestView";
import ProductDetailView from "@/views/products/ProductDetailView";
import CartView from "@/views/order/CartView";
import ProductsView from "@/views/products/ProductsView";
import OrderInfoView from "@/views/order/OrderInfoView";

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
    path: '/product/:productNo',
    name: 'ProductDetailView',
    component: ProductDetailView,
    props: true
  },

  {
    path: '/cart',
    name: 'CartView',
    component: CartView
  },
  {
    path: '/order-Info',
    name: 'OrderInfoView',
    component: OrderInfoView
  },

    ///order-info
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
