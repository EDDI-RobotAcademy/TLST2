<template>
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
          {{ writer }}
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
      <button-green btn-name="등록" depressed type="submit"/>
      <router-link :to="{ name: 'QuestionListView' }">
        <button-white btn-name="취소" depressed />
      </router-link>
    </div>
  </form>
</template>

<script>
import {mapActions, mapState} from "vuex";

export default {
  name: "QuestionRegisterForm",
  data() {
    return {
      title: '',
      categoryList :['주문/결제문의', '상품문의', '배송문의', '반품/교환문의', '양조장문의', '기타문의'],
      categoryType: '',
      writer: this.$store.state.resMember.username,
      content: '',

    }
  },
  methods: {
    ...mapActions([
      'reqMemberInfoToSpring'
    ]),

    onSubmit() {
      if (this.title !='' && this.content != '') {
        const {title, content, categoryType} = this
        const memberId = this.resMember.id
        this.$emit('submit', {title, content, memberId, categoryType})
      } else {
        alert("빈칸 없이 작성해주세요!")
      }
    },
  },
  mounted() {
    if (this.$store.state.isAuthenticated === true) {
      let token = window.localStorage.getItem('userInfo')
      this.reqMemberInfoToSpring(token)
    } else {
      alert("로그인 상태가 아닙니다.")
    }
  },
  computed : {
    ...mapState([
      'isAuthenticated',
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
  background: darkseagreen;
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