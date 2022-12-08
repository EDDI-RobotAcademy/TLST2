import {
    IS_AUTHENTICATED,
    REQUEST_PRODUCTS_LIST_FROM_SPRING,
    REQUEST_PRODUCT_FROM_SPRING,
    REQUEST_FILTERED_PRODUCT_FROM_SPRING,
    RESPONSE_MY_REQUEST
} from './mutation-types'

export default {
    [IS_AUTHENTICATED] (state, passingData) {
        state.isAuthenticated = passingData
    },
    [REQUEST_PRODUCTS_LIST_FROM_SPRING] (state, passingData) {
        state.products = passingData
    },
    [REQUEST_PRODUCT_FROM_SPRING](state, passingData) {
        state.product = passingData
    },
    [REQUEST_FILTERED_PRODUCT_FROM_SPRING](state, passingData) {
        state.products = passingData
    },
    [RESPONSE_MY_REQUEST](state, passingData) {
        state.resMyRequest = passingData
    },

}