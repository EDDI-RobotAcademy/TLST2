import 'package:flutter/material.dart';
import 'package:ztz_app/components/search/product_search_component.dart';

import '../../components/layout/menu_app_bar.dart';

class ProductSearchPage extends StatefulWidget{
  const ProductSearchPage({Key?key}) : super (key: key);

  @override
  State<ProductSearchPage> createState() => _ProductSearchPage();
}

class _ProductSearchPage extends State<ProductSearchPage>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: MenuAppBar(title: '검색',),
          body: ProductSearchComponent(),
        )
    );
  }
}