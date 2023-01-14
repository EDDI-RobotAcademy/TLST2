<template>
  <div>
      <v-card align="center">
        <v-card-title class="text-h5">
          리뷰쓰기
        </v-card-title>
        <div>
          <!-- 리뷰 작성할 상품 추가 예정 -->
          <p>{{ product.name }}</p>
          <v-img
              :src="require(`@/assets/products/uploadImg/${product.productInfo.thumbnailFileName}`)"
              max-width="200"
              max-height="150"
              contain
          ></v-img>
        </div>
        <div class="mb-3">
          <p class="mt-5 mb-3" style="font-size: 18px">상품은 만족하셨나요?</p>
          <v-rating
              v-model="rate"
              :value="rate"
              background-color="#205C37"
              color="#205C37"
              half-increments
              x-large
              hover
          ></v-rating>
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
              ref="fileUpload"
              @change="selectFile"
              @click:clear="removeFile"
              style="width: 550px"
              color="#205C37"
              prepend-icon="mdi-camera"
              label="사진 추가하기"
          ></v-file-input>
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
          <ButtonGreen
              @click="submit"
              btn-name="등록"
              large
          />
          <v-spacer></v-spacer>
        </v-card-actions>
      </v-card>
  </div>
</template>

<script>
import {mapActions, mapState} from "vuex";

export default {
  name: "ReviewRegisterForm",
  data() {
    return {
      rate: 0,
      content: '',
      image: '',
      preview: '',
      fileName: '',
      content_rule: [
        v => !!v || '필수 입력 사항입니다.',
        v => !(v && v.length < 10) || '10자 이상 입력해 주세요.',
      ]
    }
  },
  props: {
    product: {
      type: Object,
      required: true,
    },
    orderInfo : {
      type: Object,
      required: true,
    },
  },
  methods: {
    ...mapActions([
      'reqRegisterReviewToSpring',
      'reqRegisterReviewWithImageToSpring'
    ]),
    selectFile(file) {
      this.image = file
      // 사진 업로드 시 미리보기 기능
      if (!(this.image.length == 0)) {
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
      if (!(this.image.length == 0)) {
        console.log("이미지 포함 리뷰")
        //이미지 있는 경우
        let formData = new FormData()
        formData.append('image', this.image);

        let fileInfo = {
          memberId: this.resMember.id,
          productNo: this.product.productNo,
          rate: this.rate,
          content: this.content,
          orderId :this.orderInfo.orderID
        }
        formData.append("info", new Blob([JSON.stringify(fileInfo)], {type: "application/json"}))
        await this.reqRegisterReviewWithImageToSpring(formData)
      } else {
        //이미지 없는 경우
        console.log("이미지 없는 리뷰")
        const {rate, content} = this
        const memberId = this.resMember.id
        const productNo = this.product.productNo
        const orderId = this.orderInfo.orderID
        await this.reqRegisterReviewToSpring({memberId, productNo, rate, content , orderId})
      }
      await this.$router.go(this.$router.currentRoute)
    },
  },
  computed: {
    ...mapState([
      'resMember'
    ])
  },
}
</script>

<style scoped>

</style>