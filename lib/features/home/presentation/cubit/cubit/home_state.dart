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

class ChangeSelectNumFromDropDownList extends HomeState{}
class StartChangeSelectNumFromDropDownList extends HomeState{}

class LoadingSearch extends HomeState{}
class SuccessSearch extends HomeState{}


class LoadingGetSingleProductData extends HomeState{}
class SuccessGetSingleProductData extends HomeState{}
class ErrorToGetSingleProductData extends HomeState{}

