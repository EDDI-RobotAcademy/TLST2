<template>
  <div>
    <nav>
      <router-link to="/sign-up">회원가입 UI</router-link> |
      <router-link to="/sign-in">로그인 UI</router-link> |

      <router-link to="/product">상품 리스트 UI</router-link> |
      <router-link to="/my-page">마이 페이지 UI</router-link> |
      <router-link to="/cart">카트 UI</router-link> |
    </nav>
  </div>

</template>

<script>

  export default {
    name: 'WorkView',
  }
</script>
