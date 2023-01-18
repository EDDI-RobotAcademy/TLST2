<template>
  <div class="review-content">
    <v-row no-gutters>
      <v-col cols="4" align="right">
        <div class="mr-3">
          <p>{{ review.regDate }}</p>
          <v-rating
              :value="review.rate"
              background-color="grey"
              color="yellow darken-1"
              half-increments
              readonly
              dense
          ></v-rating>
        </div>
      </v-col>
      <v-col cols="8" align="left">
        <div class="ml-3" v-if="(review.thumbnailFileName == null)">
          <p>{{ review.member.username | nameFormat }}</p>
          <p>{{ review.content }}</p>
        </div>
        <div class="ml-3" v-else>
          <p>{{ review.member.username | nameFormat }}</p>
          <p>{{ review.content }}</p>
          <v-img
              :src="require(`@/assets/products/uploadImg/${review.thumbnailFileName}`)"
              height="300"
              width="400"
              contain
          ></v-img>
        </div>
      </v-col>
    </v-row>
    <v-divider></v-divider>
  </div>
</template>

<script>

export default {
  name: "ProductReviewContents",
  props: {
    review: {
      type: Object,
      required: true
    }
  },
  filters: {
    nameFormat(val) {
      return String(val).replace(/(?<=.{1})./gi, "*");
    }
  },
}
</script>

<style scoped>
p {
  font-size: 14px;
}

.review-content {
  position: relative;
  list-style: none;
  padding: 10px;

}

</style>