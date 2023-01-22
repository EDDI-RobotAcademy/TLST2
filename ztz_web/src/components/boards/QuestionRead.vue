<template>
  <div>
    <table class="boards">
      <tbody>
      <tr>
        <th scope="cols">
          문의유형
        </th>
        <td scope="cols">
          {{
            questionBoard.boardCategory.categoryType == "ORDER_PAYMENT" ? "주문/결제문의"
                : questionBoard.boardCategory.categoryType == "PRODUCT" ? "상품문의"
                    : questionBoard.boardCategory.categoryType == "DELIVERY" ? "배송문의"
                        : questionBoard.boardCategory.categoryType == "RETURN_CHANGE" ? "반품/교환문의"
                            : questionBoard.boardCategory.categoryType == "TOUR" ? "양조장문의"
                                : questionBoard.boardCategory.categoryType == "OTHER" ? "기타문의" : "카테고리오류"
          }}
        </td>
      </tr>
      <tr>
        <th scope="row">
          제목
        </th>
        <td>
          {{ questionBoard.title }}
        </td>
      </tr>
      <tr>
        <th scope="row">
          작성자
        </th>
        <td>
          {{ questionBoard.member.username | nameFormat }}
        </td>
      </tr>
      <tr>
        <th scope="row">
          작성일자
        </th>
        <td>
          {{ questionBoard.createDateTime}}
        </td>
      </tr>
      <tr>
        <th scope="row">내용</th>
        <td>
          <textarea
              cols="50"
              rows="20"
              :value="questionBoard.content"
              readonly disabled>
          </textarea>
        </td>
      </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
export default {
  name: "QuestionRead",
  props: {
    questionBoard: {
      type: Object,
      required: true,
    }
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
  background: darkgrey;
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

</style>