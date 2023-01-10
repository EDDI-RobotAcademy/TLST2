<template>
  <footer>
    <nav class="footer-nav">
        <div class ="mr-0" v-if="this.$store.state.isAuthenticated && this.$store.state.resMember.managerCheck">
           <v-row>
            <router-link style="text-decoration: none; font-weight: bold; " to="/question-list" >
              <li>Q&A</li>
            </router-link>
            <router-link style="text-decoration: none; font-weight: bold; " to="/manager" >
              <li>Admin</li>
            </router-link>
           </v-row>
        </div>
        <div class ="mr-0" v-else>
         <router-link style="text-decoration: none; font-weight: bold; " to="/question-list" >
          <li>Q&A</li>
         </router-link>
        </div>
    </nav>
    <div>
      <div class="content-box">
        <div class="footer-info">
          <p class="team">
            전통주류판매영업2팀 | 박진주, 임보경, 최재민, 김가람, 박근수
          </p>
          <p class="copyright">copyright(c) TLST2 all rights reserved.</p>
        </div>
        <div class="team-github">
          <button><v-icon color="white">mdi-plus</v-icon></button>
        </div>
      </div>
    </div>
  </footer>
</template>

<script>
import "@/css/common.css";
import {mapActions, mapState} from "vuex";

export default {
  name: "NewFooter",
  computed: {
      ...mapState(["isAuthenticated", "resMember"]),
  },
  mounted() {
      if (this.$store.state.isAuthenticated === true) {
        let token = window.localStorage.getItem("userInfo");
        this.reqMemberInfoToSpring(token);
      }
    },
  methods: {
   ...mapActions([
     "reqMemberInfoToSpring",
   ]),
  }
}
</script>
