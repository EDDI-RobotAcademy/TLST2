<template>
  <div>
    <v-dialog
        v-model="dialog"
        max-width="650"
        persistent
    >
      <v-card align="center">
        <v-card-title class="text-h5">
          리뷰 수정
        </v-card-title>
        <div>
          <!-- 리뷰 작성할 상품 추가 예정 -->
          <p>{{ review.product.name }}</p>
          <v-img
              :src="require(`@/assets/products/defaultImg/${review.product.productInfo.thumbnailFileName}`)"
              max-width="200"
              max-height="150"
              contain
          ></v-img>
        </div>
        <div>
          <p class="mt-5 mb-3">상품은 만족하셨나요?</p>
          <v-rating
              v-model="rate"
              :value="review.rate"
              background-color="#205C37"
              color="#205C37"
              half-increments
              x-large
          ></v-rating>
          <p>{{ rate }}</p>
        </div>
        <div>
          <v-textarea
              v-model="content"
              background-color="grey lighten-4"
              style="width: 600px"
              label="상품평을 작성해 주세요."
              :rules="content_rule"
              solo
              required
          ></v-textarea>
        </div>
        <div class="mb-10">
          <v-file-input
              @change="selectFile"
              @click:clear="removeFile"
              style="width: 550px"
              color="#205C37"
              prepend-icon="mdi-camera"
              label="사진 추가하기"
          ></v-file-input>
          <p>등록된 이미지</p>
          <v-img
              :src="preview"
              max-height="150"
              max-width="200"
              contain
          />
        </div>
        <v-divider></v-divider>
        <v-card-actions>
          <v-spacer></v-spacer>
          <ButtonWhite
              @click="cancel"
              btn-name="취소"
              large
          />
          <ButtonGreen
              @click="submit"
              btn-name="수정"
              large
          />
          <v-spacer></v-spacer>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import {mapActions} from "vuex";

export default {
  name: "ReviewModifyForm",
  data() {
    return {
      dialog: false,
      rate: 0,
      content: '',
      image: '',
      preview: '',
      content_rule: [
        v => !!v || '필수 입력 사항입니다.',
        v => !(v && v.length < 10) || '10자 이상 입력해 주세요.',
      ]
    }
  },
  props: {
    review: Object
  },
  created() {
    this.rate = this.review.rate
    this.content = this.review.content
    this.preview = require(`@/assets/products/uploadImg/${this.review.thumbnailFileName}`)
  },
  methods: {
    ...mapActions([
      'reqModifyReviewToSpring',
      'reqModifyReviewWithImgToSpring'
    ]),
    selectFile(file) {
      this.image = file
      // 사진 업로드 시 미리보기 기능
      if (!(this.image.length === 0)) {
        const fileData = (data) => {
          this.preview = data
        }
        const reader = new FileReader()
        reader.readAsDataURL(file)
        reader.addEventListener("load", function () {
          fileData(reader.result)
        }, false);
      }
    },
    removeFile(e) {
      e.target.file = null
      this.preview = ''
    },
    async submit() {
      if (!(this.image.length === 0)) {
        console.log("이미지 포함 리뷰 수정")

        let formData = new FormData()
        formData.append('image', this.image);

        let fileInfo = {
          rate: this.rate,
          content: this.content
        }
        const reviewNo = this.review.reviewNo
        formData.append("info", new Blob([JSON.stringify(fileInfo)], {type: "application/json"}))
        await this.reqModifyReviewWithImgToSpring({formData, reviewNo})
      } else {
        //이미지 수정 없는 경우
        console.log("이미지 없이 리뷰 수정")
        const {rate, content} = this
        const reviewNo = this.review.reviewNo
        await this.reqModifyReviewToSpring({reviewNo, rate, content})
      }
      await this.$router.go(this.$router.currentRoute)
      this.dialog = false
    },
    cancel() {
      this.dialog = false
    },
  },
  // computed: {
  //   ...mapState([
  //     'resMember'
  //   ])
  // },
  // watch: {
  //   // dialog 상태가 변경되면 실행됨
  //   dialog: function (val) {
  //     if (val) {
  //       this.image = ''
  //       this.rate = 0
  //       this.content = ''
  //       this.preview = ''
  //     }
  //   }
  // }
}
</script>

<style scoped>

</style>