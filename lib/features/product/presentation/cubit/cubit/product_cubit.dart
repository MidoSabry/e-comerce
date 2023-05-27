import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecomerce/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:ecomerce/features/product/data/model/single_product.dart';
import 'package:ecomerce/features/product/data/repositories/product_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/di.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  ProductRepositoryImpl productRepositoryImpl = ProductRepositoryImpl();

  /////////////////////add products image////////////////////////

  String selectedImagePath = '';
  XFile? imageFile;

  selectImageFromGallery() async {
    emit(PickImageLoadind());
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);

    file = await _cropImage(imageFile: file!);
    emit(PickImageSuccess());
    if (file != null) {
      imageFile = file;
      return file.path;
    } else {
      return '';
    }
  }

  selectImageFromCamera() async {
    emit(PickImageLoadind());
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 100);
    file = await _cropImage(imageFile: file!);
    emit(PickImageSuccess());
    if (file != null) {
      imageFile = file;
      return file.path;
    } else {
      return '';
    }
  }

  Future<XFile?> _cropImage({required XFile imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return XFile(croppedImage.path);
  }



  ///////////////////select category//////////////////
  String selectCategory = AppStrings.selectCategory;

   selectCategoryFunc(int index) {
    emit(loadingSelect());
    selectCategory = di<HomeCubit>().categoriesList[index];
    emit(SuccessSelect());
  }

  ////////////////add product to api///////////////////
  TextEditingController productTitleController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();


  Future addNewProduct(SingleProduct singleProduct)async{
    emit(LoadingAddProduct());
    print("hhhhh");
    print(singleProduct.title);
    print(singleProduct.category);
    print(singleProduct.description);
    print(singleProduct.price);
    print(singleProduct.image);
    try {
      await productRepositoryImpl.addSingleProduct(singleProduct);
      emit(SuccessAddProduct());
    } on DioError catch (e) {
      print(e.message);
      print(e.error);
      emit(ErrorToAddProduct());
    }

  }

  ///////////////////////update product //////////////////////////
   Future updateProduct(SingleProduct singleProduct,int productId)async{
    emit(LoadingAddProduct());
    print("hhhhh");
    print(singleProduct.title);
    print(singleProduct.category);
    print(singleProduct.description);
    print(singleProduct.price);
    print(singleProduct.image);
    try {
      await productRepositoryImpl.updateSingleProduct(singleProduct,productId);
      emit(SuccessAddProduct());
    } on DioError catch (e) {
      print(e.message);
      print(e.error);
      emit(ErrorToAddProduct());
    }

  }



  //////////////////////delete product///////////////////////////////
 Future deleteProduct(int? productId)async{
    emit(LoadingDeleteProduct());
    try {
      await productRepositoryImpl.deleteSingleProduct(productId!);
      emit(SuccessDeleteProduct());
    } on DioError catch (e) {
      print(e.message);
      print(e.error);
      emit(ErrorToDeleteProduct());
    }

  }

}
