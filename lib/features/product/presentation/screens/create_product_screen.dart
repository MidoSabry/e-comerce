import 'package:ecomerce/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:ecomerce/features/product/data/model/single_product.dart';
import 'package:ecomerce/features/product/presentation/cubit/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared/widgets/shared_button.dart';
import '../../../../core/styles/customTextFormStyle.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/di.dart';
import '../widgets/categories_bottom_sheet.dart';
import '../widgets/outline_button_widget.dart';
import '../widgets/product_image_widget.dart';

class CreateNewProduct extends StatelessWidget {
  const CreateNewProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBarWidget(isHome: false),
              BlocConsumer<ProductCubit, ProductState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Container(
                        width: MediaQuery.of(context).size.width - 40.w,
                        height: 250.h,
                        decoration: BoxDecoration(
                          // color: AppColors.lotionColor,
                          borderRadius: BorderRadius.circular(25),
                          // border: Border.all(
                          //     // color: AppColors.lotionColor,
                          //     // width: 1,
                          //     ),
                        ),
                        child: ProductPhotoWidget()),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 45.h,
                    width: 140.w,
                    child: OutLineButtonWidget(
                      onPressFunc: () async {
                        di<ProductCubit>().selectedImagePath =
                            await di<ProductCubit>().selectImageFromGallery();

                        print('Image_Path:-');
                        print(di<ProductCubit>().selectedImagePath);
                        if (di<ProductCubit>().selectedImagePath != '') {
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(AppStrings.noImageSelect),
                          ));
                        }
                      },
                      btnIcon: Icons.image_outlined,
                      btnIconColor: AppColors.primaryColor,
                      btnText: AppStrings.uploadBtn,
                      btnTextColor: AppColors.blackColor,
                    ),
                  ),
                  SizedBox(width: 13.w),
                  Container(
                    height: 45.h,
                    width: 140.w,
                    child: OutLineButtonWidget(
                      onPressFunc: () async {
                        di<ProductCubit>().selectedImagePath =
                            await di<ProductCubit>().selectImageFromCamera();
                        print('Image_Path:-');
                        print(di<ProductCubit>().selectedImagePath);

                        if (di<ProductCubit>().selectedImagePath != '') {
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(AppStrings.noImageCapture),
                          ));
                        }
                      },
                      btnIcon: Icons.camera_alt_outlined,
                      btnIconColor: AppColors.primaryColor,
                      btnText: AppStrings.cameraBtn,
                      btnTextColor: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Column(
                children: [
                  Container(
                    width: 306.w,
                    height: 50.h,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.lotionColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.lotionColor,
                        width: 1,
                      ),
                    ),
                    child: TextFormField(
                      controller: di<ProductCubit>().productTitleController,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                          hintText: AppStrings.productTitle,
                          hintStyle: hintTextStyle),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 306.w,
                    height: 50.h,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.lotionColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.lotionColor,
                        width: 1,
                      ),
                    ),
                    child: TextFormField(
                      controller: di<ProductCubit>().productPriceController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                          hintText: AppStrings.productPrice,
                          hintStyle: hintTextStyle),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  BlocConsumer<ProductCubit, ProductState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return Container(
                        width: 306.w,
                        height: 50.h,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.lotionColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.lotionColor,
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          readOnly: true,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                di<ProductCubit>().selectCategory.toString(),
                            hintStyle: di<ProductCubit>()
                                        .selectCategory
                                        .toString() !=
                                    AppStrings.selectCategory
                                ? subHeadingTextStyle.copyWith(fontSize: 17.sp)
                                : hintTextStyle,
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 30,
                              color: AppColors.blackColor,
                            ),
                          ),
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.white,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20))),
                                builder: (context) => CategoriesBottomSheet());
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 70.w,
                    height: 188.h,
                    decoration: BoxDecoration(
                      color: AppColors.lotionColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.lotionColor,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.6.h, vertical: 15.w),
                        child: TextFormField(
                          controller:
                              di<ProductCubit>().productDescriptionController,
                          maxLines: 2000,
                          maxLength: 2000,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppStrings.shortDescription,
                              hintStyle: hintTextStyle),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              BlocConsumer<ProductCubit, ProductState>(
                listener: (context, state) {
                  if (state is SuccessAddProduct) {
                    Navigator.of(context).pop();
                    di<ProductCubit>().productTitleController.text = '';
                    di<ProductCubit>().productDescriptionController.text = '';
                    di<ProductCubit>().productPriceController.text = '';
                    di<ProductCubit>().selectCategory = '';
                    di<ProductCubit>().selectedImagePath = '';
                  } else if (state is ErrorToAddProduct) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(AppStrings.error_message),
                    ));
                  }
                },
                builder: (context, state) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 30.h),
                    child: SharedButton(
                      title: AppStrings.addProduct,
                      backgroundColor: AppColors.primaryColor,
                      onPressed: () {
                        di<ProductCubit>().addNewProduct(SingleProduct(
                            title: di<ProductCubit>()
                                .productTitleController
                                .text
                                .toString(),
                            description: di<ProductCubit>()
                                .productDescriptionController
                                .text
                                .toString(),
                            price: double.parse(di<ProductCubit>()
                                .productPriceController
                                .text
                                .toString()),
                            category: di<ProductCubit>().selectCategory,
                            image: di<ProductCubit>().selectedImagePath));
                      },
                      textTitleSize: 10.sp,
                      textTitleStyle: btnTextStyle,
                      borderRaduis: 10,
                      width: 308.w,
                      height: 50.h,
                      color: AppColors.whiteColor,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
