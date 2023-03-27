<template>
    <div>
        <div class="attention-box">
            <p>
               앱 검색창에 띄울 추천 검색어 관리 페이지 입니다. 관리자만 작업해주시고 하루 한번 씩 변경 부탁드립니다.
               추가 키워드는 해당 부서에 컨펌 후 추가 부탁 드립니다.
            </p>
        </div>
        <div>
            <button-white
                medium
                width="102px"
                style="padding: 0 16px 0 10px"
                btn-name="상태변경하기"
                @click="changeStatusKeyword()"
            />
            <button-white
                medium
                width="86px"
                style="padding: 0 16px 0 10px"
                btn-name="삭제하기"
                @click="deleteKeyword()"
            />
            <input
                id="enterKeyword"
                type="text"
                v-model="enterKeyword"
                class="enterKeyword"
                required
             />
            <button-green
                medium
                width="86px"
                style="padding: 0 16px 0 10px"
                btn-name="추가하기"
                @click="addKeyword()"
            />
        </div>
        <ul class="keywordList">
            <li v-for="keyword in allRecommendedKeywordList" :key="keyword.recommendedId">
                <v-card class="mt-6" style="border-radius:20px;">
                    <v-card-title style="display:flex; justify-content: space-between;">
                        <div style="display:flex">
                            <input type="checkbox" 
                                style="accent-color: green;" 
                                name="keyword" 
                                :value="keyword" 
                                v-model="keywordsList" 
                                :id="keyword.recommendedId"
                                @change="selectUseKeyword()"
                                >
                            <div class="ml-3" style="font-size:18px; color:#2c4636">
                                {{ keyword.recommendedKeyword }}
                            </div>
                        </div>
                        
                        <p v-if="keyword.selected == true" class="use-status"> 사용중 </p>
                        <p v-else  class="use-status" > 미사용 </p>
                    </v-card-title>
                    
                    
                </v-card>
            </li>
        </ul>
    </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
    export default {
        name: "RecommendedKeywordSection",
        data(){
            return {
                keywordsList : [],
                sendData: [],
                enterKeyword: ""
            }
        },  
        computed: {
            ...mapState(["allRecommendedKeywordList"]),
        },
        mounted() {
            this.reqAllRecommendedKeyword()
        },
        methods: {
            ...mapActions([
            'reqAllRecommendedKeyword',
            'reqDeleteKeyword',
            'reqChangeStatusKeyword',
            'reqAddKeyword'
            ]),
            selectUseKeyword(){
            },
            deleteKeyword() {
                let deleteKeyword = confirm("선택한 키워드를 삭제하시겠습니까?")

                if(deleteKeyword){
                    for (let i = 0; i < this.keywordsList.length; i++) {
                        this.sendData[i] = this.keywordsList[i].recommendedId
                    }
                }
                const payload = this.sendData
                
                this.reqDeleteKeyword(payload)
                this.$router.go();
            },
            changeStatusKeyword() {
                let changeStatus = confirm("선택한 키워드의 상태를 변경하시겠습니까?")

                if(changeStatus){
                    for (let i = 0; i < this.keywordsList.length; i++) {
                        this.sendData[i] = this.keywordsList[i].recommendedId
                    }
                }
                const payload = this.sendData
                
                this.reqChangeStatusKeyword(payload)
                this.$router.go();
            },
            addKeyword(){
                let checkAddKeywordCorrect = confirm("이 키워드를 저장하시겠습니까?")

                if(checkAddKeywordCorrect) {
                    this.reqAddKeyword(this.enterKeyword)
                }
                this.$router.go();
            }
        },
    }
</script>

<style scoped>
.keywordList {display: flex; justify-content: flex-start; margin: 0; padding:0;  flex-wrap: wrap;}
.keywordList li {width: 260px; height: 80px;margin-right:20px; border-radius: 30px;}
.keywordList li :nth-child(4) {margin-right:0;}
.use-status {margin:0; padding: 2px 10px; font-size:13px; line-height:20px; border-radius: 50px;background-color: #c7d6cd; color:#2C4636;}
.enterKeyword {  padding: 5px 10px 6px; margin-top:-6px; margin-left:20px; margin-right: 10px;  border: 1px solid #ddd; border-radius: 4px;}
</style>