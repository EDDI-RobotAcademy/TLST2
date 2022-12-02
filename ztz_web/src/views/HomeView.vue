<template>
  <v-container>
    <div id="home">
      <nav>
        <router-link to="/">Home</router-link> |
        <router-link to="/sign-up">회원 가입</router-link> |
        <router-link to="/sign-in">로그인</router-link> |
        <router-link to="/sign-out">로그아웃</router-link> |
        <router-link to="/my-page">마이페이지</router-link> |
      </nav>
      <router-view/>
    </div>
  </v-container>
</template>

<script>

  export default {
    name: 'HomeView',

    components: {

    },
  }
</script>
