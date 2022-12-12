import {
    REQUEST_PRODUCTS_LIST_FROM_SPRING,
    REQUEST_FILTERED_PRODUCT_FROM_SPRING,
    REQUEST_PRODUCT_FROM_SPRING,
    RESPONSE_MY_REQUEST,
    RESPONSE_MEMBER_OBJECT,
    REQUEST_CART_LIST_FROM_SPRING,
} from './mutation-types'

// npm install axios --save-dev
import axios from 'axios'

export default {
    reqProductsFromSpring ({ commit }) {
        return axios.get('http://localhost:7777/ztz/products/list')
            .then((res) => {
                commit(REQUEST_PRODUCTS_LIST_FROM_SPRING, res.data)
                console.log(res.data)
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

    // eslint-disable-next-line no-empty-pattern
    reqAddCartToSpring({ }, payload) {
        const { memberId, productId, count} = payload
        console.log('장바구니 추가 상품번호: ' + productId +' 수량: '+count)

        return axios.post(`http://localhost:7777/ztz/order/addCartItem/${memberId}`,
            { memberId, productId, count} )
            .then(() => {
            })
    },
    reqCartListFromSpring ({ commit }, token) {
        return axios.post('http://localhost:7777/ztz/order/cartList',
            { token: token })
            .then((res) => {
                commit(REQUEST_CART_LIST_FROM_SPRING, res.data)
                console.log("장바구니 리스트 출력")
            })
    },
}