<template>
  <div>
    <form @submit.prevent="onSubmit">
      <table class="boards">
        <thead>
        <tr>
          <th scope="cols">
            제목
          </th>
          <th scope="cols">
            <input type="text" size="40" v-model="title"
                   placeholder="제목을 입력해 주세요.">
          </th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <th scope="row" cols="6" sm="3">
            카테고리
          </th>
          <td>
            <v-select v-bind:items="categoryList" v-model="categoryType" class="member-request-select"/>
          </td>
        </tr>
        </tbody>
        <tbody>
        <tr>
          <th scope="row">
            작성자
          </th>
          <td>
            <input type="text" :value="questionBoard.writer" disabled>
          </td>
        </tr>
        <tr>
          <th scope="row">
            작성일자
          </th>
          <td>
            <input type="text" :value="questionBoard.createDateTime" disabled>
          </td>
        </tr>
        <tr>
          <th scope="row">내용</th>
          <td>
            <textarea cols="50" rows="20" v-model="content"
                      placeholder="내용을 입력해 주세요.">
            </textarea>
          </td>
        </tr>
        </tbody>
      </table>

      <div>
        <button-white btn-name="수정" depressed type="submit"/>
        <router-link :to="{ name: 'QuestionReadView',
                            params: { questionNo: questionBoard.questionNo.toString() } }">
          <button-white btn-name="취소" depressed/>

        </router-link>
      </div>

    </form>
  </div>
</template>

<script>

import {mapState} from "vuex";

export default {
  name: "QuestionModify",
  props: {
    questionBoard: {
      type: Object,
      required: true,
    }
  },
  data () {
    return {
      categoryList :['주문/결제문의', '상품문의', '배송문의', '반품/교환문의', '양조장문의', '기타문의'],
      title: '',
      content: '',
      writer: '',
      regDate: '',
      categoryType: '',
    }
  },
  created () {
    this.title = this.questionBoard.title
    this.writer = this.questionBoard.writer
    this.content = this.questionBoard.content
    this.regDate = this.questionBoard.regDate
    this.categoryType = this.questionBoard.boardCategory.categoryType == "ORDER_PAYMENT"? "주문/결제문의"
        :this.questionBoard.boardCategory.categoryType == "PRODUCT"? "상품문의"
            :this.questionBoard.boardCategory.categoryType == "DELIVERY"? "배송문의"
                :this.questionBoard.boardCategory.categoryType == "RETURN_CHANGE"? "반품/교환문의"
                    :this.questionBoard.boardCategory.categoryType == "TOUR"? "양조장문의"
                        :this.questionBoard.boardCategory.categoryType == "OTHER"? "기타문의" : "카테고리오류"
  },
  methods: {
    onSubmit () {
      if( this.title != '' && this.content != '' && this.categoryType != '') {
        const { title, content, categoryType } = this
        const memberId = this.resMember.id
        this.$emit('submit', { title, content, memberId, categoryType })
      }
      else {
        alert("빈칸 없이 작성해주세요!")
      }
    }
  },
  computed : {
    ...mapState([
      'resMember',
    ]),
  },
}
</script>

<style scoped>

table.boards {
  border-collapse: collapse;
  text-align: left;
  line-height: 1.5;
  border: 1px solid #ccc;
  margin: 20px 10px;
}
table.boards thead {
  border-right: 1px solid #ccc;
  border-left: 1px solid #ccc;
  background: #205C37;
}
table.boards thead th {
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  border-right: 1px solid #ccc;
  color: #fff;
}
table.boards tbody th {
  width: 150px;
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
  background: #ececec;
}
table.boards td {
  width: 350px;
  padding: 10px;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
}
a {
  text-decoration: none;
}

</style>