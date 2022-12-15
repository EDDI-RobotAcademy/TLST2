import Vue from 'vue'
import VueRouter from 'vue-router'

import SignUpView from "@/views/account/SignUpView";
import SignInView from "@/views/account/SignInView";
import ProductDetailView from "@/views/products/ProductDetailView";
import CartView from "@/views/order/CartView";
import ProductsView from "@/views/products/ProductsView";
import OrderInfoView from "@/views/order/OrderInfoView";
import MypageView from "@/views/mypage/MypageView";
import HomeView from "@/views/HomeView";
import ModifyAddressView from "@/views/mypage/ModifyAddressView";
import FoundryView from "@/views/tour/FoundryView.vue";
import ReservationView from "@/views/tour/ReservationView.vue";
import ModifyAddressView from "@/views/mypage/ModifyAddressView";

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
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
  {
    path: '/my-page',
    name: 'MyPageView',
    component: MypageView
  },
  {
    path: '/tour',
    name: 'FoundryView',
    component: FoundryView
  },
  {
    path: '/modify-address',
    name: 'ModifyAddressView',
    component: ModifyAddressView,
    meta: {
      hideHeader: true,
    }
  },
  {
    path: '/reservation',
    name: 'ReservationView',
    component: ReservationView
  },
  {
    path: '/modify-address',
    name: 'ModifyAddressView',
    component: ModifyAddressView,
    meta:{
      hideHeader:true,
    }
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
