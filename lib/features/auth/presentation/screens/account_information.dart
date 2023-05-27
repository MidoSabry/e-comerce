import 'package:ecomerce/core/styles/customTextFormStyle.dart';
import 'package:ecomerce/core/utils/app_colors.dart';
import 'package:ecomerce/core/utils/app_strings.dart';
import 'package:ecomerce/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:ecomerce/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared/widgets/custom_title.dart';
import '../../../../core/utils/di.dart';
import '../widgets/dialogs.dart';

class AccountInformation extends StatelessWidget {
  AccountInformation({super.key, required this.userId});

  int userId = 1;

  @override
  Widget build(BuildContext context) {
    di<AuthCubit>().getUserData(userId);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is SuccessLogoutUser) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state is LoadingGetUserData || state is LoadingLogoutUser) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
                child: Column(children: [
                  CustomAppBarWidget(isHome: false),
                  SizedBox(height: 10.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          AppStrings.accountInformation,
                          style: headingTextStyle.copyWith(fontSize: 18.sp),
                        )),
                  ),
                  accountInformationDetails(),
                  SizedBox(height: 30.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          AppStrings.addressInformation,
                          style: headingTextStyle.copyWith(fontSize: 18.sp),
                        )),
                  ),
                  addressInformationDetails(),
                  // Expanded(child: SizedBox()),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: TextButton(
                          onPressed: () {
                            di<AuthCubit>().logoutUser();
                          },
                          child: Text(
                            AppStrings.logout,
                            style:
                                TextStyle(color: Colors.red, fontSize: 14.sp),
                          )),
                    ),
                  )
                ]),
              );
            }
          },
        ),
      ),
    );
  }

  Widget accountInformationDetails() => Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultTitle(
                        text: AppStrings.userName, style: blackTextStyle),
                    DefaultTitle(
                      text: di<AuthCubit>().user.username.toString(),
                      style: subHeadingTextStyle,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultTitle(
                        text: AppStrings.emailAddress, style: blackTextStyle),
                    DefaultTitle(
                      text: di<AuthCubit>().user.email.toString(),
                      style: subHeadingTextStyle,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultTitle(
                        text: AppStrings.password, style: blackTextStyle),
                    DefaultTitle(
                      text: di<AuthCubit>().user.password.toString(),
                      style: subHeadingTextStyle,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultTitle(text: AppStrings.phone, style: blackTextStyle),
                    DefaultTitle(
                      text: di<AuthCubit>().user.phone.toString(),
                      style: subHeadingTextStyle,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget addressInformationDetails() => Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultTitle(text: AppStrings.city, style: blackTextStyle),
                    DefaultTitle(
                      text: di<AuthCubit>().user.address!.city.toString(),
                      style: subHeadingTextStyle,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultTitle(
                        text: AppStrings.street, style: blackTextStyle),
                    DefaultTitle(
                      text: di<AuthCubit>().user.address!.street.toString(),
                      style: subHeadingTextStyle,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultTitle(
                        text: AppStrings.number, style: blackTextStyle),
                    DefaultTitle(
                      text: di<AuthCubit>().user.address!.number.toString(),
                      style: subHeadingTextStyle,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultTitle(text: AppStrings.zip, style: blackTextStyle),
                    DefaultTitle(
                      text: di<AuthCubit>().user.address!.zipcode.toString(),
                      style: subHeadingTextStyle,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
