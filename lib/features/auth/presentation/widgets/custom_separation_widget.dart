import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';



class CustomSeparationWidget extends StatelessWidget {
  CustomSeparationWidget({Key? key, required this.size, this.w})
      : super(key: key);
  double size = 0;
  double? w;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grayColor,
      height: size,
      width: w,
    );
  }
}
