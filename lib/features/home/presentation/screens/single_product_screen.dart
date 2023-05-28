import 'package:ecomerce/core/shared/widgets/custom_title.dart';
import 'package:ecomerce/core/styles/customTextFormStyle.dart';
import 'package:ecomerce/core/utils/app_colors.dart';
import 'package:ecomerce/core/utils/app_strings.dart';
import 'package:ecomerce/features/cart/data/model/add_cart_model.dart';
import 'package:ecomerce/features/cart/presentation/cubit/cubit/cart_cubit.dart';
import 'package:ecomerce/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared/widgets/shared_button.dart';
import '../../../../core/utils/di.dart';
import '../widgets/slider_widget.dart';

class SingleProductScreen extends StatelessWidget {
  SingleProductScreen({super.key, required this.productId});

  int productId;

  @override
  Widget build(BuildContext context) {
    di<HomeCubit>().getSingleProductData(productId);
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is LoadingGetSingleProductData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 30.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SlideWidget(),
                          SizedBox(height: 30.h),
                          Text(
                            di<HomeCubit>().product.title.toString(),
                            style: subHeadingTextBlackStyle.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 16.sp),
                            maxLines: 2,
                          ),
                          SizedBox(height: 10.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              di<HomeCubit>().product.price.toString() + ' EGP',
                              style: subHeadingTextBlackStyle.copyWith(
                                  fontWeight: FontWeight.w800, fontSize: 18.sp),
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            di<HomeCubit>().product.description.toString(),
                            style: hintTextStyle.copyWith(
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: double.infinity,
                            color: AppColors.lotionColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(AppStrings.rating,
                                    style: subHeadingTextStyle.copyWith(
                                        fontWeight: FontWeight.w600)),
                                Text(
                                  di<HomeCubit>()
                                      .product
                                      .rating!
                                      .rate
                                      .toString(),
                                  style: subHeadingTextBlackStyle.copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18.sp,
                                      color: AppColors.validateTextColorRed),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          BlocConsumer<CartCubit, CartState>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              return Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 20.h),
                                  child: SharedButton(
                                    backgroundColor: AppColors.primaryColor,
                                    title: AppStrings.addToCart,
                                    onPressed: () async {
                                      di<CartCubit>().quantityController.text =
                                          '';
                                      if (di<CartCubit>().productsInCart.any(
                                          (product) =>
                                              product.productId == productId)) {
                                        openDialogForProductIsAlreadyExist(
                                            context);
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(AppStrings
                                                    .addQuantityYouWant),
                                                content: TextFormField(
                                                  controller: di<CartCubit>()
                                                      .quantityController,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          "Enter quantity"),
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('CANCEL'),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text('OK'),
                                                    onPressed: () {
                                                      if (di<CartCubit>()
                                                          .quantityController
                                                          .text
                                                          .isEmpty) {
                                                        openDialogForEmptyQuantity(
                                                            context);
                                                      } else {
                                                        di<CartCubit>().addProductToCart(AddToCart(
                                                            productId:
                                                                productId,
                                                            ProductQuantity: int.parse(di<
                                                                    CartCubit>()
                                                                .quantityController
                                                                .text
                                                                .toString())));
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                      }
                                    },
                                    textTitleSize: 12.sp,
                                    textTitleStyle:
                                        btnTextStyle.copyWith(fontSize: 15.sp),
                                    borderRaduis: 10,
                                    width: 305.w,
                                    height: 50.h,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ));
            }
          },
        ));
  }

  Future openDialogForProductIsAlreadyExist(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            // title: Text(AppStrings.done_add_to_card.tr()),
            content: Container(
          height: 60.h,
          width: 30.w,
          child: Text(
            AppStrings.this_product_already_in_cart,
            style: subHeadingTextStyle,
          ),
        )),
      );

  Future openDialogForEmptyQuantity(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            // title: Text(AppStrings.done_add_to_card.tr()),
            content: Container(
          height: 60.h,
          width: 30.w,
          child: Text(
            AppStrings.should_enter_quantity,
            style: subHeadingTextStyle,
          ),
        )),
      );
}
