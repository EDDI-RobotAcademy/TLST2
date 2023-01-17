import 'package:flutter/material.dart';
import 'package:ztz_app/controller/search/search_info/search_info.dart';
import 'package:ztz_app/utility/colors.dart';
import 'package:ztz_app/utility/text_styles.dart';

class PopularKeywordComponent extends StatefulWidget{
  const PopularKeywordComponent({Key?key}) : super (key: key);

  @override
  State<PopularKeywordComponent> createState() => _PopularKeywordComponent();
}

class _PopularKeywordComponent extends State<PopularKeywordComponent>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: SearchInfo.popularSearchKeyword.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                    TextSpan(
                        children: [
                          const WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(right: 10.0),
                            ),
                          ),
                          TextSpan(text: (index +1).toString() + "   ", style: const TextStyle(fontSize: 15, color: ColorStyle.mainColor,fontWeight: FontWeight.w600)),
                          TextSpan(text: SearchInfo.popularSearchKeyword[index], style: blackTextStyle(15))
                        ]
                    )
                ),
                SizedBox(height: 7,),
                Divider(thickness: 0.3, color: ColorStyle.termGray,),
                SizedBox(height: 7,),
              ],
            );
          }
      ),
    );
  }


}