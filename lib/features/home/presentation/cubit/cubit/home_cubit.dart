import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../data/repositories/home_repository_impl.dart';
import '../../../data/repositories/models/products.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  HomeRepositoryImpl homeRepositoryImpl = HomeRepositoryImpl();

  ////////////////////////////get categories data/////////////////////////
  List<String> categoriesList = [];
  Future getListOfCategories() async {
    emit(LoadingGetCategoriesList());
    try {
      categoriesList = await homeRepositoryImpl.getAllCategories();
      emit(SuccessGetCategoriesList());
    } on DioError catch (e) {
      print(e.message);
      print(e.error);
      emit(ErrorToGetCategoriesList());
    }
  }

//First slider images
  List firstSliderImages = [
    ImgAssets.slide1,
    ImgAssets.slide2,
    ImgAssets.slide3,
    ImgAssets.slide4
  ];

/////////////////////////get products///////////////////////////////
  //get List of products with Limit
  List<Products> limetedProductList = [];
  Future getProductsListWithLimit() async {
    emit(LoadingGetProductsList());
    try {
      limetedProductList = await homeRepositoryImpl.getProductsWithLimit(10);
      emit(SuccessGetProductsList());
    } on DioError catch (e) {
      print(e.message);
      print(e.error);
      emit(ErrorToGetProductsList());
    }
  }

  //get List of all products
  List<Products> allProductsList = [];
  List<Products> originalAllProductsList = []; //use it to searchMethod
  Future getAllProductsList() async {
    emit(LoadingGetProductsList());
    try {
      allProductsList = await homeRepositoryImpl.getAllProducts();
      originalAllProductsList = await homeRepositoryImpl.getAllProducts();
      emit(SuccessGetProductsList());
    } on DioError catch (e) {
      print(e.message);
      print(e.error);
      emit(ErrorToGetProductsList());
    }
  }

  //get products of each category
  Future getProductsOfEachCategory(String categoryName) async {
    emit(LoadingGetProductsList());
    try {
      allProductsList =
          await homeRepositoryImpl.getProductsOfEachCategory(categoryName);
      originalAllProductsList =
          await homeRepositoryImpl.getProductsOfEachCategory(categoryName);
      emit(SuccessGetProductsList());
    } on DioError catch (e) {
      print(e.message);
      print(e.error);
      emit(ErrorToGetProductsList());
    }
  }

  //////////////////////////////sort method/////////////////////////////
  //sort list
  static final sortItems = [
    AppStrings.defoult_sort,
    AppStrings.latest_sort,
  ];

  String selectSortItem = sortItems.first;
  String kindSort = 'asc';

  void changeValueOfDropDownListOfSort(String index) {
    emit(StartChangeSelectNumFromDropDownList());
    selectSortItem = index;
    if (index == AppStrings.defoult_sort) {
      kindSort = 'asc';
    } else {
      kindSort = 'desc';
    }

    emit(ChangeSelectNumFromDropDownList());
  }

  //get list of products after sort
  Future getProductsAfterSort(String url, String sortKind) async {
    emit(LoadingGetProductsList());
    try {
      allProductsList =
          await homeRepositoryImpl.getProductsAfterSort(url, sortKind);
      originalAllProductsList =
          await homeRepositoryImpl.getProductsAfterSort(url, sortKind);
      emit(SuccessGetProductsList());
    } on DioError catch (e) {
      print(e.message);
      print(e.error);
      emit(ErrorToGetProductsList());
    }
  }

  //////////////////////search method//////////////////////
  TextEditingController textSearchController = TextEditingController();
  List<Products> suggestionAllProductsList = [];
  void productsSearch(String query) {
    emit(LoadingSearch());
    allProductsList = [];
    if (textSearchController.text.isEmpty) {
      allProductsList = originalAllProductsList;
    } else {
      suggestionAllProductsList = originalAllProductsList
          .where((element) => element.title
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();

      allProductsList = suggestionAllProductsList.toSet().toList();
    }
    emit(SuccessSearch());
  }

  //////////////////////Get single product data//////////////////////////
  Products product = Products();
  Future getSingleProductData(int productId) async {
    emit(LoadingGetSingleProductData());
    try {
      product = await homeRepositoryImpl.getSingleProductData(productId);
      emit(SuccessGetSingleProductData());
    } on DioError catch (e) {
      print(e.message);
      print(e.error);
      emit(ErrorToGetSingleProductData());
    }
  }
}
