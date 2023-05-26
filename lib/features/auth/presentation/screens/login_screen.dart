import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/shared/widgets/shared_button.dart';
import '../../../../core/styles/customTextFormStyle.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/di.dart';
import '../cubit/cubit/auth_cubit.dart';
import '../widgets/custom_separation_widget.dart';
import '../widgets/social_card_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.loginBackgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 8),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          border: Border.all(
                            color: AppColors.grayColor,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                            weight: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: MediaQuery.of(context).size.height / 15.h),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.login,
                        style: headingTextStyle,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        AppStrings.loginMessage,
                        style: hintTextStyle,
                      ),
                    ],
                  ),
                ),

                //   SizedBox(
                //     height: getProportionateScreenHeight(19),
                //   ),

                Expanded(child: SizedBox()),

                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 306.w,
                          height: 50.h,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color:
                                  di<AuthCubit>().isLoginUserNameError == false
                                      ? AppColors.whiteColor
                                      : AppColors.validateTextColorRed,
                              width: 1,
                            ),
                          ),
                          child: TextFormField(
                            controller: di<AuthCubit>().loginUserNameController,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              border: InputBorder.none,
                              hintText: AppStrings.userName,
                              hintStyle: di<AuthCubit>().isLoginUserNameError ==
                                      false
                                  ? hintTextStyle
                                  : const TextStyle(
                                      color: AppColors.validateTextColorRed),
                            ),
                            validator: (val) {
                              di<AuthCubit>().validateUserNameError(val);
                            },
                            onChanged: (val) {
                              di<AuthCubit>().isLoginUserNameError = false;
                            },
                          ),
                        ),

                        SizedBox(
                          height: 19.h,
                        ),

                        Container(
                          width: 306.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color:
                                  di<AuthCubit>().isLoginPasswordError == false
                                      ? AppColors.whiteColor
                                      : AppColors.validateTextColorRed,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Center(
                              child: TextFormField(
                                controller:
                                    di<AuthCubit>().loginPasswordController,
                                keyboardType: TextInputType.visiblePassword,
                                textAlign: TextAlign.start,
                                obscureText: di<AuthCubit>().isVisisblePassword,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: AppStrings.password,
                                    hintStyle: di<AuthCubit>()
                                                .isLoginPasswordError ==
                                            false
                                        ? hintTextStyle
                                        : const TextStyle(
                                            color:
                                                AppColors.validateTextColorRed),
                                    suffixIcon: IconButton(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onPressed: () {
                                        di<AuthCubit>()
                                            .changeVisibiltyPassword();
                                      },
                                      icon: di<AuthCubit>().isVisisblePassword
                                          ? const Icon(
                                              Icons.visibility_off_outlined,
                                              color: AppColors.grayColor)
                                          : const Icon(
                                              Icons.visibility_outlined,
                                              color: AppColors.grayColor),
                                    )),
                                validator: (val) {
                                  di<AuthCubit>().validatePasswordError(val);
                                },
                                onChanged: (val) {
                                  di<AuthCubit>().isLoginPasswordError = false;
                                },
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: getProportionateScreenHeight(9),
                        // ),
                        Visibility(
                            visible: di<AuthCubit>().isLoginUserNameError ||
                                di<AuthCubit>().isLoginPasswordError,
                            child: Text(
                              AppStrings.invalidEmailOrPassword,
                              style: validateTextStyle,
                            )),
                      ],
                    );
                  },
                ),

                Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GFCheckbox(
                        size: 18,
                        activeBgColor: AppColors.primaryColor,
                        activeBorderColor: AppColors.primaryColor,
                        customBgColor: AppColors.grayColor,
                        inactiveBgColor: AppColors.checkBoxBackgroundColor,
                        inactiveBorderColor: AppColors.checkBoxBackgroundColor,
                        value: di<AuthCubit>().isRemeber,
                        onChanged: (val) {
                          di<AuthCubit>().updateRememberMe(val);
                        }),
                    Expanded(
                      child: Text(AppStrings.rememberMe, style: hintTextStyle),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          AppStrings.forgotPassword,
                          style: TextBlackStyle.copyWith(
                              fontWeight: FontWeight.w600),
                        ))
                  ],
                ),

                Expanded(child: SizedBox()),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is SuccessLoginUser) {
                      //save in sharedprefrences
                      CacheHelper.saveData(
                          key: "jwt", value: di<AuthCubit>().jwtToken);
                      Navigator.pushNamed(
                        context,
                        Routes.services,
                      );
                      di<AuthCubit>().loginPasswordController.text == '';
                      di<AuthCubit>().loginUserNameController.text == '';
                    } else if (state is ErrorToLoginUser) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(AppStrings.error_message),
                      ));
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 20.h),
                      child: SharedButton(
                        backgroundColor:
                            //  di<AuthCubit>()
                            //                 .loginUserNameController
                            //                 .text ==
                            //             '' ||
                            //         di<AuthCubit>().loginPasswordController.text ==
                            //             ''
                            //     ? AppColors.unActiveButton
                            //     :
                            AppColors.primaryColor,
                        title: AppStrings.login,
                        onPressed: () async {
                          if (_formKey.currentState!.validate() &&
                              di<AuthCubit>().isLoginUserNameError == false &&
                              di<AuthCubit>().isLoginPasswordError == false) {
                            di<AuthCubit>().loginUser(
                                di<AuthCubit>().loginUserNameController.text,
                                di<AuthCubit>().loginPasswordController.text);
                          }
                          // else {
                          //   emailController.clear();
                          //   passwordController.clear();
                          // }
                        },
                        textTitleSize: 18,
                        textTitleStyle: btnTextStyle,
                        borderRaduis: 10,
                        width: 305.w,
                        height: 50.h,
                        color: AppColors.whiteColor,
                      ),
                    );
                  },
                ),
                Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSeparationWidget(size: 2, w: 58.w),
                    Text('  ${AppStrings.continuWiht}  '),
                    CustomSeparationWidget(size: 2, w: 58.w),
                  ],
                ),
                Expanded(child: SizedBox()),
                Platform.isAndroid
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SocialCard(icon: ImgAssets.facebook, press: () {}),
                          SocialCard(icon: ImgAssets.google, press: () {}),
                        ],
                      )
                    : Row(
                        children: [
                          SocialCard(icon: ImgAssets.facebook, press: () {}),
                          SocialCard(icon: ImgAssets.google, press: () {}),
                          SocialCard(icon: ImgAssets.apple, press: () {})
                        ],
                      ),
                Expanded(child: SizedBox()),
                Container(
                  margin: EdgeInsets.only(bottom: 35.8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.newToCAC,
                        style: textButtonStyle,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(context, Routes.signUpCoach,arguments: true);
                        },
                        child: Text(
                          AppStrings.joinNow,
                          style: TextBlackStyle.copyWith(
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: SizedBox()),
              ]),
        ),
      ),
    );
  }
}
