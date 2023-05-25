part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoadingGetCategoriesList extends HomeState {}
class SuccessGetCategoriesList extends HomeState {}
class ErrorToGetCategoriesList extends HomeState {}

class LoadingGetProductsList extends HomeState{}
class SuccessGetProductsList extends HomeState{}
class ErrorToGetProductsList extends HomeState{}
