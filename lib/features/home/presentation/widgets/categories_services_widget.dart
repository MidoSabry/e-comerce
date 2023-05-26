import 'package:ecomerce/core/styles/customTextFormStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class CategoryBox extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  CategoryBox({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          // border: Border.all(
          //   color: Colors.black,
          //   width: 1,
          // ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: headingTextStyle.copyWith(
                color: AppColors.whiteColor, fontSize: 16.sp),
          ),
        ),
      ),
    );
  }
}
