<template>
  <!--  <div class="wrap">-->
  <v-card>
    <v-card-title></v-card-title>
    <div class="board-title">
      <p style="font-size: 22px; font-weight: bold">1:1 문의 수정</p>
    </div>
    <v-divider style="border-color: black; border-width: 1px"></v-divider>
    <div class="board-container">
      <div class="board-items">
        <v-row>
          <v-col cols="2">
            <p>유형<span style="color: red"> *</span></p>
          </v-col>
          <v-col cols="10">
            <v-select
                :items="categoryList"
                v-model="categoryType"
                color="black"
                placeholder="문의유형을 선택해주세요"
                outlined>
            </v-select>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="2">
            <p>제목<span style="color: red"> *</span></p>
          </v-col>
          <v-col cols="10">
            <v-text-field
                color="black"
                placeholder="제목을 입력해주세요"
                v-model="title"
                outlined>
            </v-text-field>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="2">
            <p>내용<span style="color: red"> *</span></p>
          </v-col>
          <v-col cols="10">
            <v-textarea
                color="black"
                height="400px"
                :placeholder="contentInfo"
                v-model="content"
                outlined>

            </v-textarea>
            <p align="left" style="color:gray">
              * 상품과 무관한 내용이거나 음란 및 불법적인 내용은 통보없이 삭제될 수 있습니다.
            </p>
          </v-col>
        </v-row>
        <v-row align="center">
          <v-col>
            <div align="center" class="mb-10">
              <button-green
                  btn-name="수정하기"
                  @click="modifyBoard"
                  style="width: 200px; height: 50px; font-size: 16px">
              </button-green>
            </div>
          </v-col>
        </v-row>
      </div>
    </div>
  </v-card>
  <!--  </div>-->
</template>


<script>
import {mapActions, mapState} from "vuex";

export default {
  name: "ModifyQuestionBoardForm",
  data() {
    return {
      categoryList: ['주문/결제문의', '상품문의', '배송문의', '반품/교환문의', '양조장문의', '기타문의'],
      contentInfo: "1:1 문의 작성 전 확인해주세요." +
          "\n\n 반품 / 환불" +
          "\n - 제품 하자 혹은 이상으로 반품(환불)이 필요한 경우 구체적인 내용을 남겨주세요." +
          "\n\n 주문취소" +
          "\n - 주문취소는 배송 단계별로 방법이 상이합니다." +
          "\n - [주문완료] 상태인 경우에만 주문 취소 가능합니다." +
          "\n - [마이페이지 -> 주문관리 -> 상세페이지에서 직접 취소하실 수 있습니다." +
          "\n\n 배송" +
          "\n - 배송일 배송시간 지정은 불가능합니다.",
      categoryType: '',
      title: '',
      content: '',
    }
  },
  props: {
    questionBoard: Object
  },
  created() {
    this.title = this.questionBoard.title
    this.content = this.questionBoard.content
    this.categoryType =
        this.questionBoard.boardCategory.categoryType == "ORDER_PAYMENT"? "주문/결제문의"
        :this.questionBoard.boardCategory.categoryType == "PRODUCT"? "상품문의"
            :this.questionBoard.boardCategory.categoryType == "DELIVERY"? "배송문의"
                :this.questionBoard.boardCategory.categoryType == "RETURN_CHANGE"? "반품/교환문의"
                    :this.questionBoard.boardCategory.categoryType == "TOUR"? "양조장문의"
                        :this.questionBoard.boardCategory.categoryType == "OTHER"? "기타문의" : "카테고리오류"
  },
  methods: {
    ...mapActions([
       'requestQuestionModifyToSpring'
    ]),
    async modifyBoard() {
      if (this.title == '') {
        alert('제목을 입력해주세요')
      } else if (this.categoryType == '') {
        alert('문의유형을 선택해주세요')
      } else if (this.content == '') {
        alert('내용을 작성해주세요')
      } else {
        const {title, content, categoryType} = this
        const questionNo = this.questionBoard.questionNo
        const memberId = this.resMember.id
        this.requestQuestionModifyToSpring({questionNo, title, content, categoryType, memberId})
        await this.$router.go(this.$router.currentRoute)
      }
    },
  },
  computed: {
    ...mapState([
      'resMember'
    ])
  }
}
</script>

<style scoped>

.board-title {
  margin-left: 30px;
}

.board-container {
  display: flex;
  justify-content: center;
}

.board-items {
  margin-top: 40px;
  text-align: right;
  padding-right: 50px;
  width: 1000px;
}

.board-items p {
  margin-top: 10px;
  margin-right: 50px;
}

</style>