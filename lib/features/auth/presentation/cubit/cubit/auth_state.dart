part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoadingValidateTextFormField extends AuthState {}

class ValidateTextFormField extends AuthState {}

class ChangeVisiablePasswordIcone extends AuthState {}

class ChangeVisiablePasswordIconeSuccess extends AuthState {}

class RemeberMeCheckedState extends AuthState {}

class RemeberMeNotCheckedState extends AuthState {}
