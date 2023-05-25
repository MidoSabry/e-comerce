import 'package:ecomerce/core/styles/customTextFormStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/shared/widgets/shared_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: Image.asset(
              ImgAssets.splashImage,
              fit: BoxFit.cover,
            ),
          ),
          Center(
              child: Container(
            width: 200.w,
            height: 120.h,
            child: Text(
              'e-Commerce',
              style: headingTextStyle.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold),
            ),
          )),
          SizedBox(
            height: 300.6.h,
          ),
          Positioned.fill(
            bottom: 52.h,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SharedButton(
                    width: 152.w,
                    height: 50.h,
                    title: AppStrings.start,
                    color: AppColors.primaryColor,
                    onPressed: () {
                       Navigator.pushNamed(context, Routes.home);
                    },
                    textTitleSize: 15,
                    borderRaduis: 11,
                    textTitleStyle: btnTextStyle,
                  ),
                  SizedBox(
                    width: 24.8.w,
                  ),
                  GestureDetector(
                    onTap: () {
                       Navigator.pushNamed(context, Routes.onboarding);
                    },
                    child: Text(
                      AppStrings.joinScquad,
                      style: btnTextStyle,
                    ),
                  )
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: 10.h,
          // ),
        ],
      ),
    );
  }
}
