<template>
  <v-btn
    class="ma-2"
    color="#205C37"
    outlined
    elevation="1"
    v-on="$listeners"
    v-bind="$attrs"
    v-if="!isMobile()">
   <v-icon small>
     {{iconName}}
   </v-icon>
    <span style="width: 5px" v-if="btnName"></span>
    {{btnName}}
  </v-btn>

<!--
 isMobile이 true(모바일화면인 경우-> 화면사이즈 작음) btnName만 보임
 -->
  <v-btn
      class="ma-2"
      color="#205C37"
      outlined
      elevation="2"
      v-on="$listeners"
      v-bind="$attrs"
      v-else>
    <span style="width: 3px" v-if="btnName"></span>
    {{btnName}}
  </v-btn>
</template>

<script>
import commonMixins from '@/mixins/CommonMixins'

//mixins를 통해 isMobile()이 동작하고 휴대폰인지 pc인지를 판정

export default {
  name: "ButtonWhite",
  mixins: [commonMixins],
  props: {
    iconName: String,
    btnName: String,
  }
}
</script>

<style scoped>

</style>