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
}
