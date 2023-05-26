import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/assets_manager.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

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

  validateUserNameError(String? val){
    emit(LoadingValidateTextFormField());
    if(val == ''){
      isLoginUserNameError = true;
    }else{
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
}
