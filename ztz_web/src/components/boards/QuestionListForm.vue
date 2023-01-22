<template>
  <v-container>
    <div>
      <table class="boards" border="1">
        <thead>
        <tr>
          <th align="center" width="100">No</th>
          <th align="center" width="160">문의유형</th>
          <th align="center" width="640">제목</th>
          <th align="center" width="150">작성자</th>
          <th align="center" width="240">작성일자</th>
        </tr>
        </thead>
        <tbody>
        <tr v-if="!questionBoards || (Array.isArray(questionBoards) && questionBoards.length === 0)">
          <td colspan="5">
            현재 등록된 게시물이 없습니다!
          </td>
        </tr>
        <tr v-else v-for="(questionBoard, idx) in questionBoards" :key="idx">
          <td align="center">
            {{ questionBoard.questionNo }}
          </td>
          <td align="center">
            {{
              questionBoard.boardCategory.categoryType == "ORDER_PAYMENT" ? "주문/결제문의"
                  : questionBoard.boardCategory.categoryType == "PRODUCT" ? "상품문의"
                      : questionBoard.boardCategory.categoryType == "DELIVERY" ? "배송문의"
                          : questionBoard.boardCategory.categoryType == "RETURN_CHANGE" ? "반품/교환문의"
                              : questionBoard.boardCategory.categoryType == "TOUR" ? "양조장문의"
                                  : questionBoard.boardCategory.categoryType == "OTHER" ? "기타문의" : "카테고리오류"
            }}
          </td>
          <td align="left">
            <router-link
                :to="{ name: 'QuestionReadView',params: { questionNo: questionBoard.questionNo.toString() }}"
                style="color: black; text-decoration: none">
              <div v-if="isLogin == false" @click.prevent="readAccess(idx)">
                {{ questionBoard.title }}
              </div>
              <div v-else-if="resMember.managerCheck">
                {{ questionBoard.title }}
              </div>
              <div v-else>
                <div v-if="!questionBoard.privateCheck">
                  {{ questionBoard.title }}
                </div>
                <div v-else-if="questionBoard.member.id == resMember.id">
                  {{ questionBoard.title }}
                </div>
                <div v-else @click.prevent="readAccess(idx)">
                  <v-icon>mdi-lock-outline</v-icon>비밀글입니다.
                </div>
              </div>
            </router-link>
          </td>
          <td align="center">
            {{ questionBoard.member.username | nameFormat }}
          </td>
          <td align="center">
            {{ questionBoard.createDateTime }}
          </td>
        </tr>
        </tbody>
      </table>
    </div>
  </v-container>
</template>

<script>
import {mapState} from "vuex";

export default {
  name: "QuestionList",
  data() {
    return {
      isLogin: false
    }
  },
  mounted() {
    if (this.$store.state.isAuthenticated != false) {
      this.isLogin = true
    } else {
      this.isLogin = false
    }
  },
  methods: {
    readAccess(idx) {
      if (this.isLogin == false) {
        alert("로그인이 필요한 기능입니다.")
        this.$router.push("/sign-in")
      } else if (this.questionBoards[idx].privateCheck) {
        console.log("비밀글?")
        alert("비밀글입니다.")
      }
    }
  },
  computed: {
    ...mapState([
      'isAuthenticated',
      'resMember',
    ]),
  },
  props: {
    questionBoards: {
      type: Array
    }
  }
}
</script>

<style scoped>

table.boards {
  border-collapse: collapse;
  text-align: center;
  line-height: 1;
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
  vertical-align: center;
  border-right: 1px solid #ccc;
  color: #fff;
}

table.boards tbody th {
  padding: 10px;
  font-weight: bold;
  border-bottom: 1px solid #ccc;
  background: #ececec;
}

table.boards td {
  padding: 10px;
  vertical-align: center;
  border-bottom: 1px solid #ccc;
}

a {
  text-decoration: none;
}

</style>