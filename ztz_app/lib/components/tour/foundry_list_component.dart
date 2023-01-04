
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ztz_app/controller/tour/foundry_infos/foundry_info.dart';
import 'package:ztz_app/pages/tour/foundry_detail_page.dart';

import '../../controller/tour/reservation_controller.dart';
import 'foundry_page_list_card.dart';

class FoundryListComponent extends StatefulWidget {
  const FoundryListComponent({Key? key}) : super(key: key);

  @override
  _FoundryListComponent createState() => _FoundryListComponent();
}

class _FoundryListComponent extends State<FoundryListComponent> {

  var foundryList = false;

  @override
  void initState() {
    super.initState();
    setFoundry();
  }

  void setFoundry() async {
    await ReservationController().requestAllFoundryToSpring();
    setState(() {
      foundryList = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: foundryList == false? isNullFoundryList():isFoundryList()
    );
  }

  Widget _buildFoundryList(){
    return Container(
      child: Text('양조장'),
    );
  }


  Widget isNullFoundryList(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(30),
      child: Text("협력하는 양조장이 없습니다."),
      decoration: BoxDecoration(
          border:Border.all(
              width:1,
              color: Colors.black
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(3)
          )
      ),
    );
  }

  Widget isFoundryList(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
          children:
          List.generate(
              FoundryInfo.foundryList.length,
                  (index) => Padding(
                padding: EdgeInsets.zero,
                child: FoundryPageListCard(
                  image: FoundryInfo.foundryList[index]['imgName'],
                  name: FoundryInfo.foundryList[index]['name'],
                  address: FoundryInfo.foundryList[index]['address'],
                  tel: FoundryInfo.foundryList[index]['tel'],
                  content: FoundryInfo.foundryList[index]['content'],
                  onTap: () {
                    selectFoundryCard(index);
                  },

                  //클릭 시
                ),
              )
          )
      ),
    );
  }

  selectFoundryCard(index) async {
    setState(() {
      FoundryInfo.selectedFoundry = FoundryInfo.foundryList[index];
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => const FoundryDetailPage() ));
  }

}
