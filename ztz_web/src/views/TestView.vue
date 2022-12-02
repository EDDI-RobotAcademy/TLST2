<template>
  <v-container>
    <router-link to="/sign-up">회원가입</router-link> |
    <router-link to="/sign-in">로그인</router-link> |
    <button-white btn-name="로그아웃" @click="logout"/>
  </v-container>

</template>

<script>

  export default {
    name: 'HomeView',
    components: {

    },
    methods:{
      async logout() {
        console.log("로그아웃합니다")
        this.$store.commit('IS_AUTHENTICATED', false)
        localStorage.removeItem("userInfo")
        this.$cookies.remove('user')
        alert('로그아웃 되었습니다.')
        await this.$router.push({name:'SignInView'})
      }
    }
  }
</script>
