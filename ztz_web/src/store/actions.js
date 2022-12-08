import {
    REQUEST_PRODUCTS_LIST_FROM_SPRING,
    REQUEST_FILTERED_PRODUCT_FROM_SPRING,
    REQUEST_PRODUCT_FROM_SPRING,
    RESPONSE_MY_REQUEST,
    RESPONSE_MEMBER_OBJECT,
} from './mutation-types'

// npm install axios --save-dev
import axios from 'axios'

export default {
    reqProductsFromSpring ({ commit }) {
        return axios.get('http://localhost:7777/ztz/products/list')
            .then((res) => {
                commit(REQUEST_PRODUCTS_LIST_FROM_SPRING, res.data)
            })
    },
    reqFilteredProductsFromSpring ({ commit }, localName) {
        return axios.get(`http://localhost:7777/ztz/products/list/${localName}`)
            .then((res) => {
                commit(REQUEST_FILTERED_PRODUCT_FROM_SPRING, res.data)
            })
    },
    requestProductFromSpring({ commit }, productNo) {
        console.log('productDetailView - product 가져오기' + productNo)

        return axios.post(`http://localhost:7777/ztz/products/list/product/${productNo}`)
            .then((res) => {
                commit(REQUEST_PRODUCT_FROM_SPRING, res.data)
            })
    },
    reqDeleteMemberToSpring ({ commit }, token) {
        return axios.delete('http://localhost:7777/ztz/member/withdrawal', {
            headers: { token : token }
        }).then((res) => {
                commit(RESPONSE_MY_REQUEST, res.data)
            })
    },
    reqMemberInfoToSpring({ commit }, token) {
        return axios.post(`http://localhost:7777/ztz/member/user-verification`,
            { token: token })
            .then((res) => {
                commit(RESPONSE_MEMBER_OBJECT, res.data)
                console.log("actions :" + res.data)
            })
    },

}