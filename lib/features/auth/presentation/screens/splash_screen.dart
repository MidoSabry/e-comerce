import 'package:ecomerce/core/styles/customTextFormStyle.dart';
import 'package:ecomerce/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/shared/widgets/shared_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int splashtime = 3; // duration of splash screen on second

  @override
  void initState() {
    Future.delayed(Duration(seconds: splashtime), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(
          // pushReplacement = replacing the route so that
          // splash screen won't show on back button press
          // navigation to Home page.
          builder: (context) {
        return HomeScreen();
      }));
    });
    super.initState();
  }

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
          // Center(
          //     child: Container(
          //   width: 200.w,
          //   height: 120.h,
          //   child: Text(
          //     'e-Commerce',
          //     style: headingTextStyle.copyWith(
          //         color: AppColors.primaryColor,
          //         fontSize: 26.sp,
          //         fontWeight: FontWeight.bold),
          //   ),
          // )),
          SizedBox(
            height: 300.6.h,
          ),

          // SizedBox(
          //   height: 10.h,
          // ),
        ],
      ),
    );
  }
}
