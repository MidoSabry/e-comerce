import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/di.dart';
import '../cubit/cubit/home_cubit.dart';

class HomeWidgets {
  static Widget builFirstSlider() {
    return CarouselSlider(
      items: di<HomeCubit>().firstSliderImages.map((image) {
        return Image.asset(image);
      }).toList(),
      options: CarouselOptions(
        height: 200.h,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          // print(index);
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
