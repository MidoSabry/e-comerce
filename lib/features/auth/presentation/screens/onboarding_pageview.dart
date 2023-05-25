import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/styles/customTextFormStyle.dart';
import '../../../../../core/utils/di.dart';
import '../../../../core/shared/widgets/shared_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';

import '../cubit/cubit/auth_cubit.dart';
import '../widgets/dot.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<Widget> pages = [
    OnboardPage(
      image: di<AuthCubit>().assetImage2,
      leadText: di<AuthCubit>().textList1[0],
      contentText: di<AuthCubit>().textList2[0],
    ),
    OnboardPage(
      image: di<AuthCubit>().assetImage3,
      leadText: di<AuthCubit>().textList1[1],
      contentText: di<AuthCubit>().textList2[1],
    ),
    OnboardPage(
      image: di<AuthCubit>().assetImage1,
      leadText: di<AuthCubit>().textList1[2],
      contentText: di<AuthCubit>().textList2[2],
    ),
  ];

  final PageController pageController = PageController(initialPage: 0);

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(top: 50.h, right: 35.w),
              child: InkWell(
                onTap: () {
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => SignUpCoach()),
                  //   ModalRoute.withName('/'),
                  // );
                },
                child: Text(
                  AppStrings.skipText,
                  style: textButtonStyle.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 40.h,
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: pages,
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                });
              },
            ),
          ),
          DotsIndicator(currentPage.toDouble(), pages.length.toDouble()),
          Container(
            margin: EdgeInsets.only(bottom: 45.h),
            child: SharedButton(
              width: 308.w,
              height: 50.h,
              title: AppStrings.next,
              color: AppColors.primaryColor,
              onPressed: () {
                if (currentPage == pages.length - 1) {
                  // Navigator.pushNamed(context, Routes.signUpCoach,
                  //     arguments: false);
                } else {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              textTitleSize: 15,
              borderRaduis: 11,
              textTitleStyle: btnTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardPage extends StatelessWidget {
  final String image;
  final String leadText;
  final String contentText;

  const OnboardPage({
    Key? key,
    required this.image,
    required this.leadText,
    required this.contentText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SvgPicture.asset(
            image,
          ),
        ),
        Text(leadText, style: headingTextStyle, textAlign: TextAlign.center),
        SizedBox(
          height: 10.h,
        ),
        Text(contentText,
            style: subHeadingTextBlackStyle.copyWith(
                fontWeight: FontWeight.w500, color: Color(0xff9A9A9A)),
            textAlign: TextAlign.center),
      ],
    );
  }
}

class DotsIndicator extends AnimatedWidget {
  final double currentPage;
  final double pageCount;

  DotsIndicator(this.currentPage, this.pageCount)
      : super(listenable: ValueNotifier<double>(currentPage));

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount.toInt(), (index) => _buildDot(index)),
    );
  }

  Widget _buildDot(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 35.0.h, horizontal: 5.w),
      child: Dot(isSelected: index == currentPage.floor())
    );
  }
}


Widget dotsIndicatorGenerator(
    {required int numberOfDots, required int selectedDot}) {
  List<Widget> dots = [];
  for (int i = 0; i < numberOfDots; i++) {
    dots.add(Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4),
      child: Dot(
        isSelected: i == selectedDot,
      ),
    ));
  }
  return Padding(
    padding: const EdgeInsets.only(bottom: 24.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: dots,
    ),
  );
}
// }
