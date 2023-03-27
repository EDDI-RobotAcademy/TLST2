<template>
    <div class="wrap">
        <p class="menu-head-text">Reservation Payment</p>
        <v-card class="invoice-card mt-10">
            <v-toolbar flat color="#205c37" dark class="px-2">
                예약코드 {{ myReservationInfo.reservationId }}
            </v-toolbar>
            <ul class="invoice-box">
                <li>
                    <p>
                        <span>예약자 </span>
                        {{ myReservationInfo.member.username }} 
                    </p>
                    <p>
                        <span>예약일자 </span>
                        {{ myReservationInfo.reservationDate }} 
                    </p>
                </li>
                <li>
                    <p>
                        <span>예약인원 </span>
                        {{ myReservationInfo.numberOfMember }}
                    </p>
                    <p>
                        <span>결제금액 </span>
                        {{ this.paymentDetail.totalPaymentPrice }}
                    </p>
                </li>
            </ul>
            <div class="announce-text-box">
                <p>
                    방문하시고 싶은 양조장 변경은 예약 취소 후 새롭게 예약 부탁드립니다.
                </p>
                <p>
                    선 결제하신 예약건에 대해서는 별도의 유선 연락 후 처리해드리고 있습니다.
                </p>
                <p>유선번호 02-000-0000으로 연락 부탁드립니다.</p>
            </div>
        </v-card>
        <button-green
                type="submit"
                block
                x-large
                class="mt-6"
                btn-name="결제하기"
                @click="payment"
        >
        </button-green>

    </div>
</template>

<script>
import "@/css/initialization.css";
import { mapActions, mapState } from "vuex";
const IMP = window.IMP;
IMP.init("imp67851243");

export default {
    name: "PaymentView",
    data() {
        return {
            myReservationInfo: {},
            paymentDetail: {
                merchant_uid:"",
                reservationId: "",
                memberId:"",
                totalPaymentPrice:"",
                paymentState: true,
            }
        };
    },
    computed: {
        ...mapState([
            "resMyRequest"
        ]),
    },
    created() {
        this.myReservationInfo = this.$store.state.reservationInfo;
        const num = this.myReservationInfo.numberOfMember
        this.paymentDetail.reservationId = this.myReservationInfo.reservationId
        this.paymentDetail.memberId = this.myReservationInfo.member.id
        this.paymentDetail.totalPaymentPrice = this.myReservationInfo.foundry.price * num
        this.paymentDetail.merchant_uid = this.paymentDetail.reservationId + "0000" + this.paymentDetail.memberId
    },
    methods :{
        ...mapActions([
            'reqSaveMyPaymentReservationDetail',
        ]),

        payment() {
            IMP.request_pay({
                pg: "html5_inicis",
                pay_method: "card",
                merchant_uid: this.paymentDetail.merchant_uid,
                name: "ZTZ 전통주 결제",
                amount: 100,
                buyer_email: this.myReservationInfo.member.email,
                buyer_name: this.myReservationInfo.member.username,
                buyer_tel: this.myReservationInfo.member.phoneNumber,
                buyer_addr: "임시" ,
                buyer_postcode: "41312"
            }, rsp => { // callback
                if (rsp.success) {
                    const payload = this.paymentDetail
                    this.reqSaveMyPaymentReservationDetail(payload)
                    this.res = this.$store.state.resMyRequest

                   if (this.res === 1) {
                        alert("결제에 성공했습니다.")
                        this.$router.push({ name: "MyPageView" })
                    } 
                } else {
                    alert("결제에 실패하셨습니다. 다시 시도해주세요.")
                }
            });
        }
    }
};
</script>