import {
    REQUEST_PRODUCTS_LIST_FROM_SPRING,
    REQUEST_FILTERED_PRODUCT_FROM_SPRING, RESPONSE_MY_REQUEST
} from './mutation-types'

// npm install axios --save-dev
import axios from 'axios'

export default {
    reqProductsFromSpring ({ commit }) {
        return axios.get('http://localhost:7777/products/list')
            .then((res) => {
                commit(REQUEST_PRODUCTS_LIST_FROM_SPRING, res.data)
                console.log(res.data)
            })
    },
    reqFilteredProductsFromSpring ({ commit }, localName) {
        return axios.get(`http://localhost:7777/products/list/${localName}`)
            .then((res) => {
                commit(REQUEST_FILTERED_PRODUCT_FROM_SPRING, res.data)
            })
    },
    reqDeleteMemberToSpring ({ commit }, token) {
        return axios.delete('http://localhost:7777/ztz/member/withdrawal', {
            headers: { token : token }
        }).then((res) => {
                commit(RESPONSE_MY_REQUEST, res.data)
            })
    },

}