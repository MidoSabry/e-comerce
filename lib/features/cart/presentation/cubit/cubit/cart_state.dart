part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class LoadingGetAllMyCarts extends CartState{}
class SuccessGetAllMyCarts extends CartState{}
class ErrorToGetAllMyCarts extends CartState{}

class LoadingGetAllProductOfEachMyCarts extends CartState{}
class SuccessGetAllProductOfEachMyCarts extends CartState{}

class LoadingAddProductToCart extends CartState{}
class SuccessAddProductToCart extends CartState{}

class LoadingDeleteProductFromCart extends CartState{}
class SuccessDeleteProductFromCart extends CartState{}


class LoadingEditProductFromCart extends CartState{}
class SuccessEditProductFromCart extends CartState{}

