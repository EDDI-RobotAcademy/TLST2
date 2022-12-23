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
import QuestionReadView from "@/views/boards/QuestionReadView";
import QuestionRegisterView from "@/views/boards/QuestionRegisterView";
import QuestionModifyView from "@/views/boards/QuestionModifyView";
import MyPageReview from "@/views/mypage/MyPageReview";

import FoundryView from "@/views/tour/FoundryView.vue";
import ReservationView from "@/views/tour/ReservationView.vue";
import ModifyAddressView from "@/views/mypage/ModifyAddressView";
import ProductRegisterView from "@/views/products/ProductRegisterView";
import ProductModifyView from "@/views/products/ProductModifyView";
import CompleteView from "@/views/tour/CompleteView";
import QuestionListView from "@/views/boards/QuestionListView";
import MonthDrinkView from "@/views/month/MonthDrinkView";

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
    path: '/product-register',
    name: 'ProductRegisterView',
    component: ProductRegisterView
  },
  {
    path: '/product/:productNo',
    name: 'ProductDetailView',
    component: ProductDetailView,
    props: true
  },

  {
    path: '/product-modify/:productNo',
    name: 'ProductModifyView',
    component: ProductModifyView,
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
    path: '/reservation',
    name: 'ReservationView',
    component: ReservationView
  },
  {
    path: "/completeReservation",
    name: "CompleteView",
    component: CompleteView,
  },
  {
    path: '/modify-address',
    name: 'ModifyAddressView',
    component: ModifyAddressView,
    meta:{
      hideHeader:true,
    }
  },
  {
    path: "/question-list",
    name: "QuestionListView",
    component: QuestionListView,
  },
  {
    path: "/question-read/:questionNo",
    name: "QuestionReadView",
    components: {
      default: QuestionReadView,
    },
    props: {
      default: true,
    },
  },
  {
    path: "/question-register",
    name: "QuestionRegisterView",
    component: QuestionRegisterView,
  },
  {
    path: "/question-modify/:questionNo",
    name: "QuestionModifyView",
    components: {
      default: QuestionModifyView,
    },
    props: {
      default: true,
    },
  },
  {
    path: '/my-page/review/:memberId',
    name: 'MyPageReview',
    components: {
      default: MyPageReview
    },
    props: {
      default: true
    }
  },
  {
    path: '/month',
    name: 'MonthDrinkView',
    component: MonthDrinkView
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
