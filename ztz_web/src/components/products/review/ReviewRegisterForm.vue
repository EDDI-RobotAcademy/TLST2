<template>
  <div>
    <v-dialog
        v-model="dialog"
        max-width="650"
    >
      <v-card align="center">
        <v-card-title class="text-h5">
          리뷰쓰기
        </v-card-title>
        <div>
          <!-- 리뷰 작성할 상품 추가 예정 -->
          <p>리뷰 작성할 상품 보여주기</p>
        </div>
        <div>
          <p class="mt-5 mb-3">상품은 만족하셨나요?</p>
          <v-rating
              v-model="rate"
              :value="rate"
              background-color="#205C37"
              color="#205C37"
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
              solo
          ></v-textarea>
        </div>
        <div class="mb-10">
          <v-file-input
              v-model="file"
              @change="previewFile(file)"
              @click:clear="removeFile"
              style="width: 550px"
              color="#205C37"
              prepend-icon="mdi-camera"
              label="사진 추가하기"
          />
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
              @click="btnCloseDialog"
              btn-name="취소"
              large
          />
          <ButtonGreen
              @click="btnRegisterReview"
              btn-name="등록"
              large
          />
          <v-spacer></v-spacer>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
export default {
  name: "ReviewRegisterForm",
  data() {
    return {
      dialog: false,
      rate: 0,
      content: '',
      preview: '',
    }
  },
  methods: {
    previewFile(file) {
      const fileData = (data) => {
        this.preview = data
      }
      const reader = new FileReader()
      reader.readAsDataURL(file)
      reader.addEventListener("load", function () {
        fileData(reader.result)
      }, false);
    },
    removeFile() {
      this.preview = ''
    },
    btnCloseDialog() {
      // 취소 버튼 추가 구현 예정
      this.dialog = false
    },
    btnRegisterReview() {
      // 리뷰 등록 버튼 추가 구현 예정
      this.dialog = false
    }


  },
}
</script>

<style scoped>

</style>