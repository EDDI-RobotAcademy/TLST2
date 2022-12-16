import {
    REQUEST_PRODUCTS_LIST_FROM_SPRING,
    REQUEST_FILTERED_PRODUCT_FROM_SPRING,
    REQUEST_PRODUCT_FROM_SPRING,
    RESPONSE_MY_REQUEST,
    RESPONSE_MEMBER_OBJECT,
    REQUEST_CART_LIST_FROM_SPRING,
    RESPONSE_MEMBER_PROFILE_OBJET,
    REQUEST_FOUNDRY_LIST,
    REQUEST_QUESTION_LIST_FROM_SPRING,
    REQUEST_QUESTION_FROM_SPRING,
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
        return axios.get('http://localhost:7777/ztz/tour/list')
            .then((res) => {
                commit(REQUEST_FOUNDRY_LIST, res.data)
                console.log(res.data)
            })
    },
    reqMemberProfileInfoToSpring({ commit }, token) {
        return axios.post(`http://localhost:7777/ztz/member/user-profile`,
            { token: token })
            .then((res) => {
                commit(RESPONSE_MEMBER_PROFILE_OBJET, res.data)
                console.log("profile :" + res.data)
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
    // eslint-disable-next-line no-empty-pattern
    reqReadReviewFromSpring({ }, productNo) {
    console.log(productNo + '번 상품의 리뷰 가져오기')
    },

    // 질문게시판 리스트 UI
    requestQuestionListFromSpring ({ commit }) {
        console.log('requestQuestionListFromSpring()')

        return axios.get('http://localhost:7777/ztz/boards/question/list')
            .then((res) => {
                commit(REQUEST_QUESTION_LIST_FROM_SPRING, res.data)
            })
    },

    // 질문게시판 조회(읽기)
    requestQuestionFromSpring ({ commit }, questionNo) {
        console.log('requestQuestionFromSpring()')
        return axios.get(`http://localhost:7777/ztz/boards/question/${questionNo}`)
            .then((res) => {
                commit(REQUEST_QUESTION_FROM_SPRING, res.data)
            })
    },

    // 질문게시판 등록
    // eslint-disable-next-line no-empty-pattern
    requestCreateQuestionContentsToSpring ({ }, payload) {
        console.log('requestCreateQuestionContentsToSpring()')
        const { title, content, writer } = payload
        return axios.post('http://localhost:7777/ztz/boards/question/register',
            { title, content, writer })
            .then(() => {
                alert('등록 완료했습니다!')
            })
    },

    // 질문게시판 수정
    // eslint-disable-next-line no-empty-pattern
    requestQuestionModifyToSpring ({ }, payload) {
        console.log('requestQuestionModifyToSpring()')

        const { title, content, questionNo, writer, regDate } = payload

        return axios.put(`http://localhost:7777/ztz/boards/question/${questionNo}`,
            { title, content, writer, regDate })
            .then(() => {
                alert('수정 완료했습니다!')
            })
    },

    // 질문게시판 삭제
    // eslint-disable-next-line no-empty-pattern
    requestDeleteQuestionToSpring ({ }, questionNo) {
        console.log('requestDeleteQuestionToSpring()')

        return axios.delete(`http://localhost:7777/ztz/boards/question/${questionNo}`)
            .then(() => {
                alert('삭제 완료했습니다!')
            })
    },
}