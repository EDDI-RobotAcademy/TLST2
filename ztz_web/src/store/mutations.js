import {
    REQUEST_PRODUCTS_LIST_FROM_SPRING,
    REQUEST_PRODUCT_FROM_SPRING,
    REQUEST_FILTERED_PRODUCT_FROM_SPRING
} from './mutation-types'

export default {
    [REQUEST_PRODUCTS_LIST_FROM_SPRING] (state, passingData) {
        state.products = passingData
    },
    [REQUEST_PRODUCT_FROM_SPRING](state, passingData) {
        state.product = passingData
    },
    [REQUEST_FILTERED_PRODUCT_FROM_SPRING](state, passingData) {
        state.products = passingData
    },

}