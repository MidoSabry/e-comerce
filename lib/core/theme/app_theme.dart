import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_strings.dart';
import '../styles/customTextFormStyle.dart';

ThemeData appTheme() {
  return ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.primaryColor,
      ),
      primaryColor: AppColors.primaryColor,
      hintColor: AppColors.grayColor,
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      fontFamily: AppStrings.fontFamily,
      textTheme: TextTheme(
        bodyMedium: subHeadingTextStyle,
      ));
}
