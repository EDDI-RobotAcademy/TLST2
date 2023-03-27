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
    REQUEST_QUESTION_LIST_FROM_SPRING,
    REQUEST_QUESTION_FROM_SPRING,
    REQUEST_FILTERED_ALCOHOL_PRODUCT_FROM_SPRING,
    REQUEST_MY_RESERVATION_LIST_FROM_SPRING,
    REQUEST_ALL_ORDER_LIST_FROM_SPRING,
    REQUEST_ALL_PAYMENT_FROM_SPRING,
    REQUEST_QUESTION_COMMENT_LIST_FROM_SPRING,
    REQUEST_BEST_PRODUCTS_LIST_FROM_SPRING,
    REQUEST_SALES_AMOUNT_TO_SPRING,
    REQUEST_MANAGER_PHONENUMBER_FROM_SPRING,
    REQUEST_ORDER_FROM_SPRING,
    REQUEST_PRODUCT_FAVORITE_INFO_FROM_SPRING,
    REQUEST_PRODUCT_REVIEW_AVERAGE_FROM_SPRING,
    REQUEST_MY_FAVORITE_LIST_FROM_SPRING,
    REQUEST_FAVORITE_PRODUCTS_FROM_SPRING,
    REQUEST_ALL_RECOMMENDED_KEYWORD_LIST,
    REQUEST_FILTERED_LOCAL_AND_ALCOHOL_FROM_SPRING,
    REQUEST_MEMBER_QUESTION_BOARD_FROM_SPRING,
} from "./mutation-types";

import axios from "axios";

export default {

    reqProductsFromSpring({commit}, keyword) {
        let url = `http://localhost:7777/ztz/products/list`
        if(keyword != undefined){
            url += '?keyword='+encodeURIComponent(keyword)
        }
        return axios.post(url)
            .then((res) => {
                commit(REQUEST_PRODUCTS_LIST_FROM_SPRING, res.data)
            })
    },
    reqFilteredProductsFromSpring({commit}, localName) {
        return axios.get(`http://localhost:7777/ztz/products/list/${localName}`)
            .then((res) => {
                commit(REQUEST_FILTERED_PRODUCT_FROM_SPRING, res.data)
            })
    },
    reqFilteredLocalAndAlcoholProductsFromSpring({commit}, payload) {
        const { alcoholType, localName } = payload
        return axios.post(`http://localhost:7777/ztz/products/list/by-local-type`, {alcoholType, localName})
            .then((res) => {
                commit(REQUEST_FILTERED_LOCAL_AND_ALCOHOL_FROM_SPRING, res.data)
            })
    },
    requestProductFromSpring({commit}, productNo) {

        return axios.post(`http://localhost:7777/ztz/products/list/product/${productNo}`)
            .then((res) => {
                commit(REQUEST_PRODUCT_FROM_SPRING, res.data)
            })
    },
    reqFilteredAlcoholProductsFromSpring ({ commit }, alcoholType) {
        return axios.post(`http://localhost:7777/ztz/products/alcoholList/${alcoholType}`)
            .then((res) => {
                commit(REQUEST_FILTERED_ALCOHOL_PRODUCT_FROM_SPRING, res.data)
            })
    },
    reqDeleteMemberToSpring({commit}, token) {
        return axios.delete('http://localhost:7777/ztz/member/withdrawal', {
            headers: {token: token}
        }).then((res) => {
            commit(RESPONSE_MY_REQUEST, res.data)
        })
    },
    reqMemberInfoToSpring({commit}, token) {
        return axios.post(`http://localhost:7777/ztz/member/user-verification`,
            {token: token})
            .then((res) => {
                commit(RESPONSE_MEMBER_OBJECT, res.data)
            })
    },
    reqFoundryListFromSpring({commit}) {
        return axios.get('http://localhost:7777/ztz/tour/list')
            .then((res) => {
                commit(REQUEST_FOUNDRY_LIST, res.data)
            })
    },
    reqReservationToSpring({commit}, payload) {
        return axios.post("http://localhost:7777/ztz/tour/reservation", payload)
            .then((res) => {
                commit(RESPONSE_MY_REQUEST, res.data);
            });
    },
    reqMyReservationListToSpring({ commit }, token) {
        return axios
          .get("http://localhost:7777/ztz/tour/my-reservation", {
            headers: { Token: token },
          })
          .then((res) => {
            commit(REQUEST_MY_RESERVATION_LIST_FROM_SPRING, res.data);
          });
      },

    reqAllReservationListToSpring({commit}) {
        return axios.get('http://localhost:7777/ztz/tour/allReservationList')
            .then((res) => {
                commit(REQUEST_MY_RESERVATION_LIST_FROM_SPRING, res.data)
            })
    },
    reqCancelMyReservation({ commit }, payload) {
        return axios
          .delete(
            `http://localhost:7777/ztz/tour/my-reservation/${payload.reservationId}`,
            {
              headers: { Token: payload.token },
            }
          )
          .then((res) => {
            commit(RESPONSE_MY_REQUEST, res.data);
          });
      },
    reqModifyReservation({ commit }, payload) {
        return axios
          .put(
            `http://localhost:7777/ztz/tour/my-reservation/${payload.reservationId}`,
            payload
          )
          .then((res) => {
            commit(RESPONSE_MY_REQUEST, res.data);
          });
    },
    reqSaveMyPaymentReservationDetail({ commit }, payload) {
        return axios.post(`http://localhost:7777/ztz/tour/my-reservation/payment`, payload)
          .then((res) => {
            commit(RESPONSE_MY_REQUEST, res.data);
          });
    },
    reqMemberProfileInfoToSpring({commit}, token) {
        return axios.post(`http://localhost:7777/ztz/member/user-profile`,
            {token: token})
            .then((res) => {
                commit(RESPONSE_MEMBER_PROFILE_OBJET, res.data)
            })
    },
    reqRegisterReviewToSpring(_, payload) {
        return axios.post('http://localhost:7777/ztz/products/review/register', payload)
            .then(() => {
            })
    },
    reqRegisterReviewWithImageToSpring(_, payload) {
        return axios.post('http://localhost:7777/ztz/products/review/registerWithImg', payload)
            .then((res) => {
                console.log(res.data)
            })
            .catch((res) => {
                console.log(res.message)
            })
    },
    reqReadReviewFromSpring({commit}, productNo) {
        return axios.post(`http://localhost:7777/ztz/products/review/read/${productNo}`)
            .then((res) => {
                commit(REQUEST_READ_REVIEW_FROM_SPRING, res.data)
            })
    },
    reqMyPageReviewFromSpring({commit}, memberId) {
        return axios.post(`http://localhost:7777/ztz/products/review/read/myPage/${memberId}`)
            .then((res) => {
                commit(REQUEST_READ_REVIEW_FROM_SPRING, res.data)
            })
    },
    requestQuestionListFromSpring({commit}) {
        return axios.get('http://localhost:7777/ztz/boards/question/list')
            .then((res) => {
                commit(REQUEST_QUESTION_LIST_FROM_SPRING, res.data)
            })
    },
    requestQuestionFromSpring({commit}, questionNo) {
        return axios.get(`http://localhost:7777/ztz/boards/question/${questionNo}`)
            .then((res) => {
                commit(REQUEST_QUESTION_FROM_SPRING, res.data)
            })
    },
    // eslint-disable-next-line no-empty-pattern
    requestCreateQuestionContentsToSpring({}, payload) {
        const {title, content, memberId, categoryType, privateCheck} = payload
        return axios.post('http://localhost:7777/ztz/boards/question/register',
            {title, content, memberId, categoryType, privateCheck})
            .then(() => {
                alert('등록 완료했습니다!')
            })
    },
    // eslint-disable-next-line no-empty-pattern
    requestQuestionModifyToSpring({}, payload) {
        const {title, content, questionNo, memberId, categoryType, privateCheck} = payload

        return axios.put(`http://localhost:7777/ztz/boards/question/${questionNo}`,
            {title, content, memberId, categoryType, privateCheck})
            .then(() => {
                alert('수정 완료했습니다!')
            })
    },
    // eslint-disable-next-line no-empty-pattern
    requestDeleteQuestionToSpring({}, questionNo) {
        return axios.delete(`http://localhost:7777/ztz/boards/question/${questionNo}`)
            .then(() => {
                alert('삭제 완료했습니다!')
            })
    },
    requestQuestionCommentListFromSpring ({ commit }, questionNo) {
        return axios.get(`http://localhost:7777/ztz/boards/question/comment/${questionNo}`)
            .then((res) => {
                commit(REQUEST_QUESTION_COMMENT_LIST_FROM_SPRING, res.data)
            })
    },
    // eslint-disable-next-line no-empty-pattern
    requestQuestionCommentRegisterToSpring ({ }, payload) {
        const { comment, questionNo, memberId } = payload
        return axios.post('http://localhost:7777/ztz/boards/question/comment/register',
            { comment : comment, question_no : questionNo, member_no : memberId})
            .then(() => {
                alert('댓글 등록을 완료하였습니다.')
            })
    },
    // eslint-disable-next-line no-empty-pattern
    requestDeleteQuestionCommentToSpring({}, questionCommentNo) {
        return axios.delete(`http://localhost:7777/ztz/boards/question/comment/${questionCommentNo}`)
            .then(() => {
                alert('삭제 완료했습니다!')
            })
    },
    reqDeleteReviewToSpring(_, reviewNo) {
        return axios.delete(`http://localhost:7777/ztz/products/review/delete/${reviewNo}`)
            .then(() => {
                alert('삭제 완료했습니다.')
            })
    },
    reqModifyReviewToSpring(_, payload) {
        const {reviewNo, rate, content} = payload

        return axios.put(`http://localhost:7777/ztz/products/review/modify/${reviewNo}`,
            {rate, content})
            .then(() => {
                alert('리뷰를 수정했습니다.')
            })
    },
    reqModifyReviewWithImgToSpring(_, payload) {
        const {formData, reviewNo} = payload

        return axios.put(`http://localhost:7777/ztz/products/review/modifyWithImg/${reviewNo}`, formData)
            .then((res) => {
                console.log(res.data)
                alert('리뷰를 수정했습니다.')
            })
            .catch((res) => {
                console.log(res.message)
            })
    },
    reqOrderedListFromSpring({commit}, paymentId) {
        return axios.post(`http://localhost:7777/ztz/order/ReadAllOrder/${paymentId}`)
            .then((res) => {
                commit(REQUEST_ALL_ORDER_LIST_FROM_SPRING, res.data)
            })
    },
    reqOrderInfoById({commit}, orderInfoId){
        return axios.post(`http://localhost:7777/ztz/order/readOrder/${orderInfoId}`)
            .then((res) => {
                commit(REQUEST_ORDER_FROM_SPRING, res.data)
            })
    },
    reqPaymentListFromSpring({commit}, token) {
        return axios.post(`http://localhost:7777/ztz/order/ReadAllPayment`,
            {token: token})
            .then((res) => {
                commit(REQUEST_ALL_PAYMENT_FROM_SPRING, res.data)
            })
    },
    // eslint-disable-next-line no-empty-pattern
    reqRefundAllOrderToSpring({}, payload) {
        const {refundPaymentId, refundReason} = payload
        return axios.post(`http://localhost:7777/ztz/order/refundAllOrder/${refundPaymentId}`, {
            refundPaymentId,
            refundReason
        })
            .then((res) => {
                console.log(res)
            })
    },
    reqChangeOrderStateToSpring({commit, dispatch }, payload){
        const {reqType, orderId, paymentId} = payload

        return axios.post(`http://localhost:7777/ztz/order/changeOrderState`, {reqType, orderId, paymentId})
            .then((res) => {
                commit(REQUEST_ALL_ORDER_LIST_FROM_SPRING, res.data)
                dispatch('reqPaymentListFromSpring')
            })
    },
    // eslint-disable-next-line no-empty-pattern
    requestDeleteProductToSpring ({ }, productNo) {

        return axios.delete(`http://localhost:7777/ztz/products/${productNo}`)
            .then(() => {
                alert('상품이 삭제되었습니다.')
            })
    },
    // eslint-disable-next-line no-empty-pattern
    reqRegisterOrderToSpring({}, payload){
        const { paymentPrice, merchant_uid , sendInfo , imp_uid, city, street, addressDetail, zipcode ,sendRequest} = payload
        return axios.post(`http://localhost:7777/ztz/order/OrderRegister`,
            {paymentPrice, merchant_uid , sendInfo , imp_uid, city, street, addressDetail, zipcode ,sendRequest})

            .then((res) => {
                console.log(res)
            })
    },
    reqBestProductsFromSpring({commit}) {
        return axios.post('http://localhost:7777/ztz/products/list/view')
            .then((res) => {
                commit(REQUEST_BEST_PRODUCTS_LIST_FROM_SPRING, res.data)
            })
    },
    // eslint-disable-next-line no-empty-pattern
    reqCheckMonthAlcoholToSpring({dispatch}, productNo){
        return axios.post(`http://localhost:7777/ztz/products/monthAlcohol/${productNo}`)
            .then((res) => {
                alert(res.data)
                dispatch('reqProductsFromSpring')
            })
    },
    reqMonthAlcoholProductsFromSpring({commit}) {
        return axios.get(`http://localhost:7777/ztz/products/monthAlcohol/list`)
            .then((res) => {
                commit(REQUEST_PRODUCTS_LIST_FROM_SPRING, res.data)
            })
    },
    reqSalesAmountToSpring({commit}){
        return axios.get(`http://localhost:7777/ztz/order/salesAmount`)
            .then((res) => {
                commit(REQUEST_SALES_AMOUNT_TO_SPRING, res.data)
            })
    },

    // eslint-disable-next-line no-empty-pattern
    reqMyPageProfileModifyFromSpring({}, payload) {
        const { managerCheck, phoneNumber, manager_code, present_password, new_password, memberId } = payload;

        return axios.post("http://localhost:7777/ztz/member/modify-profile", {
            managerCheck:managerCheck, phoneNumber, manager_code, password : present_password, new_password, id: memberId
        })
            .then((res) => {
                alert(res.data)
            })
            .catch((res) => {
                alert(res.response.data.message)
            })
    },
    reqManagerProfileInfoToSpring({commit}, token) {
        return axios.post("http://localhost:7777/ztz/member/manager-profile",
                    {token: token})
                    .then((res) => {
                        commit(REQUEST_MANAGER_PHONENUMBER_FROM_SPRING, res.data)
                    })
    },
    reqMyCartListFromSpring({commit}, token) {
        return axios.get('http://localhost:7777/ztz/order/myCart',{headers: { Token: token },
            }).then((res) => {
                commit(REQUEST_CART_LIST_FROM_SPRING, res.data)
            })
    },
    reqCartItemCountChangeToSpring({commit}, payload) {
        return axios.post("http://localhost:7777/ztz/order/change-item-count", payload)
            .then((res) => {
                commit(RESPONSE_MY_REQUEST, res.data);
            });
    },
    // eslint-disable-next-line no-empty-pattern
    reqDeleteCartItemFromSpring({}, payload) {
        const selectCartItemNo = payload

        return axios.post(`http://localhost:7777/ztz/order/delete-items`,
            {selectCartItemNo})
            .then(() => {
            })
    },
    // eslint-disable-next-line no-empty-pattern
    reqAddCartToSpring({}, payload) {
    const {productNo, count, token} = payload

    return axios.post(`http://localhost:7777/ztz/order/add`,
        {productNo, count, token})
        .then(() => {
        })
    },
    reqReadRangePaymentList({ commit }, payload) {
        const { token, readData } = payload

        return axios.post(`http://localhost:7777/ztz/order/readPayment/byDate`,
            { token, readData })
            .then((res) => {
                commit(REQUEST_ALL_ORDER_LIST_FROM_SPRING, res.data);
            });
    },
    reqSaveFavoriteToSpring({commit}, payload) {
        const {memberId, productNo, favoriteType} = payload

        return axios.post("http://localhost:7777/ztz/products/favorite/changeFavoriteStatus", {memberId, productNo, favoriteType})
            .then((res) => {
                commit(REQUEST_PRODUCT_FAVORITE_INFO_FROM_SPRING, res.data);
            });
    },
    reqMyFavoriteListToSpring({commit}, payload) {
        const token = payload

        return axios.post("http://localhost:7777/ztz/products/favorite/myFavorite", {token:token})
            .then((res) => {
                commit(REQUEST_MY_FAVORITE_LIST_FROM_SPRING, res.data);
            });
    },
    reqFavoriteProductsFromSpring({commit}) {
        return axios.post('http://localhost:7777/ztz/products/list/favorite')
            .then((res) => {
                commit(REQUEST_FAVORITE_PRODUCTS_FROM_SPRING, res.data)
            })
    },
    reqProductReviewAvgFromSpring({commit}, productNo) {
        return axios.post(`http://localhost:7777/ztz/products/review/read/average/${productNo}`)
            .then((res) => {
                commit(REQUEST_PRODUCT_REVIEW_AVERAGE_FROM_SPRING, res.data);
            })
    },
    reqAllRecommendedKeyword({commit}) {
        return axios.get('http://localhost:7777/ztz/search/all-keywords-list')
        .then((res) => {
                commit(REQUEST_ALL_RECOMMENDED_KEYWORD_LIST, res.data)
        })
    },
    reqChangeStatusKeyword({commit}, payload) {
        const selectedKeywords = payload
        return axios.post('http://localhost:7777/ztz/search/select', {selectedKeywords})
        .then((res) => {
                commit(RESPONSE_MY_REQUEST, res.data)
        })
    },
    reqAddKeyword({commit}, payload) {
        const enterKeyword = payload

        return axios.post('http://localhost:7777/ztz/search/save', {enterKeyword})
        .then((res) => {
                commit(RESPONSE_MY_REQUEST, res.data)
        })
    },
    reqDeleteKeyword({commit}, payload) {
        const selectedKeywords = payload

        return axios.post('http://localhost:7777/ztz/search/delete', {selectedKeywords})
        .then((res) => {
                commit(RESPONSE_MY_REQUEST, res.data)
        })
    },
    reqMemberQuestionBoardFromSpring({commit}, token) {
        return axios.post('http://localhost:7777/ztz/boards/question/list/member',
            { token: token })
            .then((res) => {
                commit(REQUEST_MEMBER_QUESTION_BOARD_FROM_SPRING, res.data);
            })
    },
    reqModifyQuestionCommentToSpring(_, payload) {
        const {questionCommentNo, comment, questionNo, memberId} = payload
        return axios.put(`http://localhost:7777/ztz/boards/question/comment/modify/${questionCommentNo}`,
            {comment : comment, question_no : questionNo, member_no : memberId})
            .then(() => {
                alert('댓글을 수정하였습니다.')
            })
    },

}