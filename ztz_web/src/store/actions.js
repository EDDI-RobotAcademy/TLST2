import {
    REQUEST_PRODUCTS_LIST_FROM_SPRING,
    REQUEST_FILTERED_PRODUCT_FROM_SPRING,
    REQUEST_PRODUCT_FROM_SPRING,
    RESPONSE_MY_REQUEST,
    RESPONSE_MEMBER_OBJECT,
    REQUEST_CART_LIST_FROM_SPRING,
    RESPONSE_MEMBER_PROFILE_OBJET,
    REQUEST_FOUNDRY_LIST,
    REQUEST_READ_REVIEW_FROM_SPRING,
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
    reqFoundryListFromSpring ({ commit }) {
        return axios.get('http://localhost:7777/ztz/reservation/list')
            .then((res) => {
                commit(REQUEST_FOUNDRY_LIST, res.data)
                console.log(res.data)
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
    // eslint-disable-next-line no-empty-pattern
    reqDeleteCartItemFromSpring({}, payload) {
        const selectCartItemNo = payload

        console.log('장바구니 아이템 삭제 전')

        return axios.post(`http://localhost:7777/ztz/order/deleteCartItem`,
            { selectCartItemNo} )
            .then(() => {
            })
    },
    reqRegisterReviewToSpring(_, payload) {
        console.log('이미지 미포함 리뷰 등록하기')

        return axios.post('http://localhost:7777/ztz/products/review/register', payload)
            .then(() => {
            })
    },
    reqRegisterReviewWithImageToSpring(_, payload) {
        console.log("이미지 포함 리뷰 등록하기")
        return axios.post('http://localhost:7777/ztz/products/review/registerWithImg', payload)
            .then((res) => {
                console.log(res.data)
            })
            .catch((res) => {
                console.log(res.message)
            })
    },
    reqReadReviewFromSpring({ commit }, productNo) {
        console.log(productNo + '번 상품의 리뷰 가져오기')

        return axios.post(`http://localhost:7777/ztz/products/review/read/${productNo}`)
            .then((res) => {
                commit(REQUEST_READ_REVIEW_FROM_SPRING, res.data)
            })

    },
    // eslint-disable-next-line no-empty-pattern
    reqRegisterOrderToSpring({}, payload) {
        const { paymentPrice, merchant_uid , sendInfo} = payload
        return axios.post("http://localhost:7777/ztz/order/OrderRegister", {
            paymentPrice , merchant_uid , sendInfo
        })
            .then((res) => {
                console.log(res)
                })
            .catch((res) => {
                alert(res.response.data.message)
            })
    },
}