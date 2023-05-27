part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class PickImageLoadind extends ProductState{}
class PickImageSuccess extends ProductState{}

class loadingSelect extends ProductState{}
class SuccessSelect extends ProductState{}

class LoadingAddProduct extends ProductState{}
class SuccessAddProduct extends ProductState{}
class ErrorToAddProduct extends ProductState{}

class LoadingDeleteProduct extends ProductState{}
class SuccessDeleteProduct extends ProductState{}
class ErrorToDeleteProduct extends ProductState{}


