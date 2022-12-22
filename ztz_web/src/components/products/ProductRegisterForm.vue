<template>
  <div id='registerForm'>
    <v-form @submit.prevent="onSubmit">

      <div id="title" class="mb-15">
        <h2>상품 등록하기</h2>
      </div>
      <table>
        <v-row>
          <v-col cols="3">
            <v-row>
              <h3 class="mt-1 ml-1">대표 이미지</h3>
              <div>
                <v-btn class="mt-0" text>
                  <label for="thumbnailFile">
                    <v-icon>mdi-camera</v-icon><v-icon>mdi-plus</v-icon>
                  </label>
                  <input type="file" id="thumbnailFile" ref="thumbnailFile"
                         v-on:change="handleFileUpload" hidden/>
                </v-btn>
              </div>
            </v-row>
            <v-row class="mt-7">
              <table class="thumbTable" width="320px" height="240px">
                <tr>
                  <td>
                    <div v-if="this.thumbnailFile.length > 0">
                      <v-icon align="right" style="align-items: end" @click="thumbnailCancel">mdi-close</v-icon>
                      <v-img :src="thumbnailPreview" width="200px" style="margin-left: auto; margin-right: auto; display: block;"/>
                    </div>
                    <div v-else>
                      <p style="color: #888888; font-size: medium; text-align: center" >preview</p>
                    </div>
                  </td>
                </tr>
              </table>
            </v-row>

          </v-col>

          <v-col>

            <v-row class="mt-10 ml-1">
              <v-col cols="2"><h4>상품명</h4></v-col>
              <v-text-field outlined color="grey darken-1" placeholder="상품명을 입력해주세요." v-model="name" dense/>
            </v-row>

            <v-row class="ml-1">

              <v-col cols="2"><h4>브랜드</h4></v-col>
              <v-text-field
                  outlined color="grey darken-1"
                  dense
                  placeholder="브랜드를 입력해주세요"
                  v-model="brand">
              </v-text-field>

              <v-col cols="2" align="center"><h4>맛</h4></v-col>
              <v-combobox
                  v-model="taste"
                  :items="tasteType"
                  label="맛"
                  style="width:200px;"
                  multiple
                  outlined
                  dense>
              </v-combobox>

            </v-row>

            <v-row class="ml-1">
              <v-col cols="2"><h4>제조지역</h4></v-col>
              <v-select
                  v-model="region"
                  :items="regionType"
                  label="지역"
                  style="width:200px;"
                  outlined
                  dense>
              </v-select>
              <v-col cols="2" align="center"><h4>주류 타입</h4></v-col>
              <v-select
                  v-model="alcohol"
                  :items="alcoholType"
                  label="주류 카테고리"
                  style="width:200px;"
                  outlined
                  dense>
              </v-select>
            </v-row>

            <v-row class="ml-1">

              <v-col cols="2"><h4>가격</h4></v-col>
              <!-- 폰트 변경으로 배치가 깨져서 가격, 배송비의 text-field width를 200px으로 변경함 -->
              <v-text-field
                  style="width: 200px"
                  type="number"
                  outlined color="grey darken-1"
                  dense
                  placeholder="가격을 입력해주세요(단위: 원)"
                  v-model="price">
              </v-text-field>

              <v-col cols="2" align="center"><h4>배송비</h4></v-col>

              <v-text-field
                  style="width: 200px"
                  type="number"
                  outlined color="grey darken-1"
                  dense
                  placeholder="배송비를 입력해주세요(단위: 원)"
                  v-model="deliveryFee">
              </v-text-field>
            </v-row>

          </v-col>
        </v-row>

        <v-divider class="mt-10"/>

        <v-row class=" mt-7">
            <v-col cols="2"><h4>상품 간단 설명</h4></v-col>
            <v-text-field
                outlined color="grey darken-1"
                placeholder="상품의 간단한 설명을 입력해주세요"
                v-model="subtitle">
            </v-text-field>
          </v-row>

        <v-row class=" mt-7">
          <v-col cols="2"><h4>상품 상세 설명</h4></v-col>
          <textarea
              style="border-color: #888888" cols="95" rows="5"
              placeholder="상품의 상세한 설명을 입력해주세요"
              v-model="description">
          </textarea>
        </v-row>

        <v-row class="mt-10">

          <v-col cols="2"><h4>상품 상세 사진</h4></v-col>
            <div class="ml-0">
              <v-btn  class="ma-2"
                      color="#205C37"
                      outlined
                      elevation="1"
              >
                <label for="multipleFiles"> upload
                  <v-icon>mdi-camera</v-icon>
                </label>
                <input type="file" id="multipleFiles" ref="multipleFiles"
                       multiple v-on:change="handleMultipleFileUpload" hidden/>
              </v-btn>
           </div>
          <div class="mt-4 ml-2" v-if="!this.multipleFiles.length > 0">
            <p >업로드 시 미리보기 가능합니다</p>
          </div>

        </v-row>

        <v-row class="mt-10">
          <table v-show="this.multipleFiles.length > 0">
            <tr>
              <td align="right"><v-btn text color="grey" style="font-size: 16px" @click="uploadCancel">cancel<v-icon>mdi-delete-outline</v-icon></v-btn></td>
            </tr>
            <tr v-for="(image, index) in this.multiplePreview" :key="index"  style="border-bottom: none">
              <td colspan="4" class="imageTd" >
                <v-img :src="image"
                       max-width="750px" contain style="margin-left: auto; margin-right: auto; display: block;" />
              </td>
            </tr>
          </table>
        </v-row>


        <!-- 등록하기 -->
        <v-row class="justify-center mt-15 mb-5">
          <div>
            <button-white @click="cancel" large style="width: 200px;font-size: 18px" btn-name="취소"/>
            <button-green type="submit" large style="width: 200px;font-size: 18px" btn-name="등록"/>
          </div>

        </v-row>





      </table>
    </v-form>
  </div>

</template>

<script>
import axios from "axios";

export default {
  name: "ProductRegisterForm",
  data() {
    return {
      name:'',
      region: '',
      alcohol: '',
      taste:'',
      regionType: [
        '서울경기',
        '강원',
        '전라',
        '충청',
        '경상',
        '제주'
      ],
      alcoholType:[
        '소주증류주',
        '리큐르',
        '막걸리',
        '약주청주',
        '과실주',
        '기타주류'
      ],
      tasteType:[
          '달달',
          '시원',
          '씁쓸',
          '탄산',
          '새콤',
          '과일향'
      ],
      brand:'',
      subtitle:'',
      description:'',
      price:'',
      deliveryFee:'',
      uploadPreImageUrl:[],
      uploadPreThumbnailUrl:[],

      thumbnailFile:'',
      multipleFiles: '',
      fileNum:0,
      multiplePreview:[],
      thumbnailPreview:[]
    }
  },
  methods: {
    handleFileUpload(){
      this.thumbnailFile = this.$refs.thumbnailFile.files
      this.thumbnailPreview =URL.createObjectURL(this.thumbnailFile[0])
    },
    handleMultipleFileUpload () {
      this.multipleFiles = this.$refs.multipleFiles.files
      this.fileNum += this.$refs.multipleFiles.files.length
      for (let i = 0; i < this.$refs.multipleFiles.files.length; i++) {
        this.multiplePreview[i]= URL.createObjectURL(this.$refs.multipleFiles.files[i])
      }
    },

    async onSubmit () {
      console.log('상품 등록- registerform')

      //파일 업로드한 경우
      if(!this.multipleFiles.length == 0 && !this.thumbnailFile.length == 0){
        let formData = new FormData()

        formData.append('thumbnail', this.thumbnailFile[0] )

        for (let idx = 0; idx < this.multipleFiles.length; idx++) {
          console.log("파일리스트 반복문:"+idx)
          formData.append('fileList', this.multipleFiles[idx])
        }

        let productContents = {
          brand: this.brand,
          name: this.name,
          price: this.price,
          deliveryFee:this.deliveryFee,
          type: this.alcohol,
          local: this.region,
          taste: this.taste,
          subTitle: this.subtitle,
          description: this.description
        }

        formData.append(
            "info",
            new Blob([JSON.stringify(productContents)], { type: "application/json" })
        )
        await axios.post('http://localhost:7777/ztz/products/register', formData)
            .then (res => {
              alert(res.data)
            })
            .catch(res => {
              alert(res.message)
            })

        this.$router.push({name: 'ProductsView'})
        //파일 업로드 하지 않은 경우
      } else{
        alert("상품 사진을 업로드해주세요")

      }

    },
    thumbnailCancel(){
      this.thumbnailFile = ''
      this.$refs.thumbnailFile.value=''
    },
    uploadCancel(){
      this.multipleFiles = ''
      this.$refs.multipleFiles.value=''
    },
    cancel() {
      this.$router.go(-1)
    },

  }
}
</script>

<style scoped>
table {
  margin-top: 5px;
  width: 100%;
}
tr{
  border: none;
}
td{
  border: none;
}
table.thumbTable{
  border : 1px solid lightgray;
  border-collapse : collapse;
}
#registerForm{
  display: block;
  margin-top: 60px;
  margin: 50px;
  border: 1px solid lightgray;
  width: 1000px;
  margin: 0 auto;
  padding: 40px;
  line-height: 24px;
  margin-bottom: 50px;
}
</style>