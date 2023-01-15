import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ztz_app/components/my_page/review_management/review_management_appbar.dart';
import 'package:ztz_app/components/my_page/review_management/writable_review_component.dart';
import 'package:ztz_app/components/my_page/review_management/written_review_component.dart';

class ReviewManagementPage extends StatefulWidget{
  const ReviewManagementPage({Key?key}) : super (key: key);

  @override
  State<ReviewManagementPage> createState() => _ReviewManagementPage();
}

class _ReviewManagementPage extends State<ReviewManagementPage>{
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: ReviewManagementAppbar(),
        body: TabBarView(
          children: [
            SafeArea(
              child: SingleChildScrollView(child: WritableReviewComponent()),
            ),
            SafeArea(
              child: SingleChildScrollView(child: WrittenReviewComponent()),
            ),
          ],
        ),
      )
    );
  }


}