import 'package:flutter/material.dart';
import 'package:ztz_app/components/category/category_form.dart';
import 'package:ztz_app/components/layout/menu_app_bar.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MenuAppBar(title: '카테고리'),
        body: CategoryForm()
    );
  }
}
