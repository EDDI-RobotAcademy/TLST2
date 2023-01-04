
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  List<String> imagesList = [
    "assets/images/banner/carousel1.jpg",
    "assets/images/banner/carousel4.jpg",
    "assets/images/banner/carousel2.jpg",
    "assets/images/banner/carousel3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height:200,
        enlargeCenterPage: true,
        autoPlay: true,
        initialPage: 2,
        onPageChanged: (position, reason) {
        },
        enableInfiniteScroll: false,
      ),
      items: imagesList.map<Widget>((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: double.infinity,
              decoration:
              BoxDecoration(image: DecorationImage(image: AssetImage(i)) ),
            );
          },
        );
      }).toList(),
    );
  }
}