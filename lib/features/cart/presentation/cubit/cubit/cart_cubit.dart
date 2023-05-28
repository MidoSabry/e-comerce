import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
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

  addProductToCart(AddToCart addToCart) {
    emit(LoadingAddProductToCart());
    productsInCart.add(addToCart);
    getAllDataInCart();
    emit(SuccessAddProductToCart());
  }

  //////////////////get all data in cart///////////////
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

    print(myAllCartProducts);
    emit(SuccessGetAllMyCarts());
  }

  /////////////////delete specific cart///////////////
  deleteSpecificItem(int index) {
    emit(LoadingDeleteProductFromCart());
    myAllCartProducts.removeAt(index);
    productsInCart.removeAt(index);
    emit(SuccessDeleteProductFromCart());
  }

  ///////////////////Edit specific cart///////////////
  TextEditingController editQuantityController = TextEditingController();
  editSpecificItem(int index) {
    emit(LoadingEditProductFromCart());
    productsInCart[index].ProductQuantity =
        int.parse(editQuantityController.text.toString());
    emit(SuccessEditProductFromCart());
  }
}
