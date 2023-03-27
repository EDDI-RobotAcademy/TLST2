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