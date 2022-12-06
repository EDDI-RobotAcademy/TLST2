import {
    IS_AUTHENTICATED,
} from './mutation-types'

export default {

    [IS_AUTHENTICATED] (state, passingData) {
        state.isAuthenticated = passingData
    },
}