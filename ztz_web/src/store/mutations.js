import {
    IS_AUTHENTICATED,
    REQUEST_PRODUCTS_LIST_FROM_SPRING,
    REQUEST_PRODUCT_FROM_SPRING,
    REQUEST_FILTERED_PRODUCT_FROM_SPRING,
    RESPONSE_MEMBER_OBJECT,
    RESPONSE_MY_REQUEST,
    REQUEST_CART_LIST_FROM_SPRING,
    REQUEST_ORDER_LIST_FROM_SPRING,
    RESPONSE_MEMBER_PROFILE_OBJET,
    REQUEST_READ_REVIEW_FROM_SPRING,
    REQUEST_QUESTION_LIST_FROM_SPRING,
    REQUEST_QUESTION_FROM_SPRING,
    REQUEST_QUESTION_COMMENT_LIST_FROM_SPRING,
    REQUEST_FOUNDRY_LIST,
    REQUEST_FOUNDRY_INFO,
    SAVE_RESERVATION_INFO,
    REQUEST_ALL_ORDER_LIST_FROM_SPRING,
    REQUEST_ALL_PAYMENT_FROM_SPRING,
} from "./mutation-types"

export default {
    [IS_AUTHENTICATED](state, passingData) {
        state.isAuthenticated = passingData
    },
    [REQUEST_PRODUCTS_LIST_FROM_SPRING](state, passingData) {
        state.products = passingData
    },
    [REQUEST_PRODUCT_FROM_SPRING](state, passingData) {
        state.product = passingData
    },
    [REQUEST_FILTERED_PRODUCT_FROM_SPRING](state, passingData) {
        state.products = passingData
    },
    [RESPONSE_MEMBER_OBJECT](state, passingData) {
        state.resMember = passingData
    },
    [RESPONSE_MY_REQUEST](state, passingData) {
        state.resMyRequest = passingData
    },
    [REQUEST_CART_LIST_FROM_SPRING](state, passingData) {
        state.cartList = passingData
    },
    [REQUEST_ORDER_LIST_FROM_SPRING](state, passingData) {
        state.orderList = passingData
    },
    [RESPONSE_MEMBER_PROFILE_OBJET](state, passingData) {
        state.resMemberProfile = passingData
    },
    [REQUEST_READ_REVIEW_FROM_SPRING](state, passingData) {
        state.reviews = passingData
    },
    [REQUEST_QUESTION_LIST_FROM_SPRING](state, passingData) {
        state.questionBoards = passingData
    },
    [REQUEST_QUESTION_FROM_SPRING](state, passingData) {
        state.questionBoard = passingData
    },
    [REQUEST_QUESTION_COMMENT_LIST_FROM_SPRING] (state, passingData) {
        state.questionComments = passingData
    },
    [REQUEST_FOUNDRY_LIST](state, passingData) {
        state.foundrys = passingData
    },
    [REQUEST_FOUNDRY_INFO](state, passingData) {
        state.selectedFoundry = passingData
    },
      [SAVE_RESERVATION_INFO](state, passingData) {
        state.reservationInfo = passingData
      },
    [REQUEST_ALL_ORDER_LIST_FROM_SPRING](state, passingData){
        state.orderedList = passingData
    },
    [REQUEST_ALL_PAYMENT_FROM_SPRING](state,passingData){
        state.paymentList = passingData
    }
}

