import 'package:flutter/material.dart';

/* 아임포트 결제 모듈을 불러옵니다. */
import 'package:iamport_flutter/iamport_payment.dart';
/* 아임포트 결제 데이터 모델을 불러옵니다. */
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:ztz_app/components/layout/menu_app_bar.dart';
import 'package:ztz_app/pages/tour/reservation_payment_result.dart';

class ReservationPayment extends StatefulWidget {
  const ReservationPayment({Key? key,
    required this.reservationId,
    required this.reservationNumberOfMember,
    required this.paymentState,
    required this.totalPaymentPrice,
    required this.reservationPhoneNumber,
    required this.reservationDate,
    required this.reservationMemberName,
    required this.reservationFoundryName,
  }) : super(key: key);

  @override
  _ReservationPayment createState() => _ReservationPayment();

  final int reservationId, reservationNumberOfMember, totalPaymentPrice;
  final bool paymentState;
  final String reservationPhoneNumber, reservationMemberName, reservationFoundryName, reservationDate;
}

class _ReservationPayment extends State<ReservationPayment> {
  @override
  Widget build(BuildContext context) {
    return IamportPayment(
      appBar: MenuAppBar(title: "ZTZ 양조장 결제",),
      /* 웹뷰 로딩 컴포넌트 */
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo/logo.png'),
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              Text('Loading...', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
      /* [필수입력] 가맹점 식별코드 */
      userCode: 'imp67851243',
      /* [필수입력] 결제 데이터 */
      data: PaymentData(
          pg: 'html5_inicis',                                          // PG사
          payMethod: 'card',                                           // 결제수단
          name: 'ZTZ 양조장 선결제',                                  // 주문명
          merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}', // 주문번호
          amount: 100 /*widget.totalPaymentPrice*/,                                               // 결제금액
          buyerName: widget.reservationMemberName,                                           // 구매자 이름
          buyerTel:  widget.reservationPhoneNumber,                                    // 구매자 연락처
          // buyerEmail: 'example@naver.com',                             // 구매자 이메일
          // buyerAddr: '서울시 강남구 신사동 661-16',                         // 구매자 주소
          // buyerPostcode: '06018',                                      // 구매자 우편번호
          appScheme: 'example',                                        // 앱 URL scheme
          cardQuota : [2,3]                                            //결제창 UI 내 할부개월수 제한
      ),
      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ReservationPaymentResult(result: result, reservationId:widget.reservationId, totalPaymentPrice:widget.totalPaymentPrice)),
        );
        debugPrint("결제완료 전: $result['success']");
      },
    );
  }
}