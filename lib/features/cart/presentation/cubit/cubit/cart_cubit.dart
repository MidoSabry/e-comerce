import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecomerce/core/utils/cache_helper.dart';
import 'package:ecomerce/features/cart/data/model/add_cart_model.dart';
import 'package:ecomerce/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ecomerce/features/home/data/repositories/home_repository_impl.dart';
import 'package:ecomerce/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/di.dart';
import '../../../../home/data/repositories/models/products.dart';
import '../../../data/model/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  CartRepositoryImp cartRepositoryImp = CartRepositoryImp();
  HomeRepositoryImpl homeRepositoryImpl = HomeRepositoryImpl();

  ////////////////////get all my carts//////////////////
  // List<Cart> myAllCarts = [];
  // List<Products> myAllCartProducts = [];
  // Products product = Products();
  // List<Map<int, Products>> productsOfEachCart = [];

  // List<Map<int, CartProducts>> cartpro = [];

  // Future getAllMyCartsList(int userId) async {
  //   emit(LoadingGetAllMyCarts());

  //   try {
  //     myAllCarts = await cartRepositoryImp.getUserCart(userId);

  //     myAllCarts.forEach((element) {
  //       element.cartProducts!.forEach((cartProduct) async {
  //         // product = await homeRepositoryImpl
  //         //     .getSingleProductData(cartProduct.productId!);

  //         // print('${element.id},,,,,${cartProduct.productId}');
  //         Map<int, Products> val = {};
  //         val[element.id!] = await homeRepositoryImpl
  //             .getSingleProductData(cartProduct.productId!);
  //         // print('${val.keys},,,,,${val.values.first.title}');

  //         productsOfEachCart.add(val);

  //         // print(element.id);
  //         // print(product.title);
  //       });
  //       // print("lllllllllllllllllllllllllllllll");
  //       // productsOfEachCart.forEach((element) {
  //       //   element.forEach((key, value) {
  //       //     print('${key},,,,,,,${value}');
  //       //   });
  //       // });
  //       // print(productsOfEachCart);
  //     });

  //     // myAllCarts.forEach((cart) {
  //     //   cart.cartProducts!.forEach((item) {
  //     //     cartpro.add({cart.id!: item});
  //     //   });
  //     // });

  //     // var keys = cartpro.map((e) => e.keys).expand((e) => e).toSet();

  //     print(productsOfEachCart);

  //     emit(SuccessGetAllMyCarts());
  //   } on DioError catch (e) {
  //     print(e.message);
  //     print(e.error);
  //     emit(ErrorToGetAllMyCarts());
  //   }
  // }

  // getProductOfEachCart(int productId) async {
  //   emit(LoadingGetAllProductOfEachMyCarts());
  //   product = await homeRepositoryImpl.getSingleProductData(productId);
  //   myAllCartProducts.add(product);
  //   emit(SuccessGetAllProductOfEachMyCarts());
  // }

  ////////////////////add to cart//////////////////////
  List<AddToCart> productsInCart = [];

  TextEditingController quantityController = TextEditingController();

  ///////////////////get data from shared prefrences////////////////
  getCartDataFromSharedPref() {
    if (CacheHelper.getData(key: "productsInCart") != null) {
      String ListOfCartDataAsSting = CacheHelper.getData(key: "productsInCart");
      productsInCart = (jsonDecode(ListOfCartDataAsSting) as List<dynamic>)
          .map((e) => AddToCart.fromJson(e))
          .toList();
      getAllDataInCart();
    } 
  }

  addCartDataFromSharedPref(List<AddToCart> addToCartData) {
    String ListOfProductsInCartToSave = jsonEncode(productsInCart);
    CacheHelper.saveData(
        key: "productsInCart", value: ListOfProductsInCartToSave);
    getCartDataFromSharedPref();
    getAllDataInCart();
  }

  //////////////add data to cart//////////////////////////

  addProductToCart(AddToCart addToCart) {
    emit(LoadingAddProductToCart());
    getCartDataFromSharedPref();
    productsInCart.add(addToCart);
    addCartDataFromSharedPref(productsInCart);
    emit(SuccessAddProductToCart());
  }

  //////////////////get all data in cart from api///////////////
  List<Products> myAllCartProducts = [];
  Products product = Products();

  getAllDataInCart() async {
    emit(LoadingGetAllMyCarts());
    productsInCart.forEach((element) async {
      product =
          await homeRepositoryImpl.getSingleProductData(element.productId);

      if (!myAllCartProducts
          .any((product) => product.id == element.productId)) {
        myAllCartProducts.add(product);
      }
    });

    // print("gettt");
    // print(myAllCartProducts);
    emit(SuccessGetAllMyCarts());
  }

  /////////////////delete specific cart///////////////
  deleteSpecificItem(int productId) {
    emit(LoadingDeleteProductFromCart());

    getCartDataFromSharedPref();

    myAllCartProducts.removeWhere((element) => element.id == productId);
    productsInCart.removeWhere((element) => element.productId == productId);
    addCartDataFromSharedPref(productsInCart);
    emit(SuccessDeleteProductFromCart());
  }

  ///////////////////Edit specific cart///////////////
  TextEditingController editQuantityController = TextEditingController();
  editSpecificItem(int productId) {
    emit(LoadingEditProductFromCart());
    getCartDataFromSharedPref();
    // productsInCart[index].ProductQuantity =
    //     int.parse(editQuantityController.text.toString());
    productsInCart.forEach((element) {
      if (element.productId == productId) {
        element.ProductQuantity =
            int.parse(editQuantityController.text.toString());
      }
    });
    String ListOfProductsInCartToSave = jsonEncode(productsInCart);
    CacheHelper.saveData(
        key: "productsInCart", value: ListOfProductsInCartToSave);
    // print(productsInCart[index].ProductQuantity);
    emit(SuccessEditProductFromCart());
  }

  //////////////////add to cart api//////////////////////
  Future uploadProductToCartAPI() async {
    emit(LoadingUploadProductToCart());
    try {
      DateTime now = DateTime.now();
      String formattedDate =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
      print(formattedDate);
      getCartDataFromSharedPref();
      await cartRepositoryImp.addProductToCart(
          1, formattedDate, productsInCart);
      emit(SuccessUploadProductToCart());
    } on DioError catch (e) {
      print(e.message);
      print(e.error);
      emit(ErrorToUploadProductToCart());
    }
  }
}
