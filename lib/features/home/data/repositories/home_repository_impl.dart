import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecomerce/features/home/data/repositories/models/products.dart';

import '../../../../core/constants/end_points.dart';
import '../../../../core/utils/dio_helper.dart';
import '../../domain/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  /////////////get all categories////////////////////
  @override
  Future<List<String>> getAllCategories() async {
    var result;
    result = await DioHelper.getData(path: EndPoints.getAllCategories);

    List<String> categoriesList =
        (result.data as List<dynamic>).map((item) => item.toString()).toList();

    return categoriesList;
  }

///////////////////get products with Limit///////////////////////////
  @override
  Future<List<Products>> getProductsWithLimit(int limit) async {
    var result;
    result =
        await DioHelper.getData(path: '${EndPoints.getProducts}?limit=$limit');

    List<dynamic> resultData = result.data;

    List<Products> productList =
        resultData.map((item) => Products.fromJson(item)).toList();

    return productList;
  }

  /////////////////get all products////////////////////////////////////
  @override
  Future<List<Products>> getAllProducts() async {
    var result;
    result = await DioHelper.getData(path: EndPoints.getProducts);

    List<dynamic> resultData = result.data;

    List<Products> productList =
        resultData.map((item) => Products.fromJson(item)).toList();

    return productList;
  }

  /////////////////////Get all products of each category///////////////

  @override
  Future<List<Products>> getProductsOfEachCategory(String categoryName) async {
    var result;
    result = await DioHelper.getData(
        path: '${EndPoints.getProductsOfEachCategory}/$categoryName');

    List<dynamic> resultData = result.data;

    List<Products> productList =
        resultData.map((item) => Products.fromJson(item)).toList();

    return productList;
  }

  ////////////////get products after sort/////////////////////
  @override
  Future<List<Products>> getProductsAfterSort(
      String url, String sortKind) async {
    var result;
    print('$url?sort=$sortKind');
    result = await DioHelper.getData(path: '$url?sort=$sortKind');

    List<dynamic> resultData = result.data;

    List<Products> productList =
        resultData.map((item) => Products.fromJson(item)).toList();

    return productList;
  }

  ///////////////////get Single product data///////////////////////

  @override
  Future<Products> getSingleProductData(int productId) async {
    var result;
    result =
        await DioHelper.getData(path: '${EndPoints.getProducts}/$productId');

    Products product = Products.fromJson(result.data);

    return product;
  }
}
