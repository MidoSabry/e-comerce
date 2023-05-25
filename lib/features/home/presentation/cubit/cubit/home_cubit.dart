import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/assets_manager.dart';
import '../../../data/repositories/home_repository_impl.dart';
import '../../../data/repositories/models/products.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  HomeRepositoryImpl homeRepositoryImpl = HomeRepositoryImpl();

  //get categories data
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

  //get List of products
  List<Products> productList = [];
  Future getProductsListWithLimit() async {
    emit(LoadingGetProductsList());
    try {
      productList = await homeRepositoryImpl.getProductsWithLimit(10);
      emit(SuccessGetProductsList());
    } on DioError catch (e) {
      print(e.message);
      print(e.error);
      emit(ErrorToGetProductsList());
    }
  }
}
