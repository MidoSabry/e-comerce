import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecomerce/core/utils/cache_helper.dart';
import 'package:ecomerce/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../data/model/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl();

  final String assetImage1 = '$imgPath/onboard1.svg';
  final String assetImage2 = '$imgPath/onboard2.svg';
  final String assetImage3 = '$imgPath/onboard3.svg';
  final textList1 = [
    AppStrings.onboard1,
    AppStrings.onboard2,
    AppStrings.onboard3
  ];
  final textList2 = [
    AppStrings.lourphim,
    AppStrings.lourphim,
    AppStrings.lourphim
  ];

  ////////////////////////Login screen/////////////////////////////

  bool isLoginUserNameError = false;
  bool isLoginPasswordError = false;
  String loginErrorMsg = 'Invalid userName or password';

  TextEditingController loginUserNameController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  validateUserNameError(String? val) {
    emit(LoadingValidateTextFormField());
    if (val == '') {
      isLoginUserNameError = true;
    } else {
      isLoginUserNameError = false;
    }
    emit(ValidateTextFormField());
  }

  validatePasswordError(String? val) {
    emit(LoadingValidateTextFormField());
    if (val == '') {
      isLoginPasswordError = true;
    } else {
      isLoginPasswordError = false;
    }

    emit(ValidateTextFormField());
  }

  bool isVisisblePassword = true;
  void changeVisibiltyPassword() {
    emit(ChangeVisiablePasswordIcone());
    isVisisblePassword = !isVisisblePassword;
    emit(ChangeVisiablePasswordIconeSuccess());
  }

  //get token id (Login)
  String jwtToken = '';
  Future loginUser(String userName, String password) async {
    emit(LoadingLoginUser());
    try {
      jwtToken = await authRepositoryImpl.loginUser(userName, password);
      emit(SuccessLoginUser());
    } on DioError catch (e) {
      print(e.message);
      print(e.error);
      emit(ErrorToLoginUser());
    }
  }

  // validateEmailError(String? val) {
  //   emit(LoadingValidateTextFormField());
  //   if (val == '') {
  //     isLoginEmailError = true;
  //     emailMsgError = 'Email is empty';
  //   } else if (!RegExp(
  //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  //       .hasMatch(val!)) {
  //     isLoginEmailError = true;
  //     emailMsgError = 'Email is wrong';
  //   } else {
  //     isLoginEmailError = false;
  //   }

  //   emit(ValidateTextFormField());
  // }

  //Remember me
  bool isRemeber = false;
  bool isChecked = false;
  updateRememberMe(bool? val) {
    isChecked = val!;
    if (val == false) {
      isRemeber = false;
      emit(RemeberMeNotCheckedState());
    }
    if (val == true) {
      isRemeber = true;
      emit(RemeberMeCheckedState());
    }
  }

  //////////////////////get user data//////////////////////
  User user = User();
  Future getUserData(int userId) async {
    emit(LoadingGetUserData());
    try {
      user = await authRepositoryImpl.getUserData(userId);
      emit(SuccessGetUserData());
    } on DioError catch (e) {
      print(e.message);
      print(e.error);
      emit(ErrorToGetUserData());
    }
  }

  ////////////////////Logout User/////////////////
  logoutUser() {
    emit(LoadingLoginUser());
    print("hee");
    CacheHelper.removeData(key: "jwt");
    emit(SuccessLogoutUser());
  }
}
