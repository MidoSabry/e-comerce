import 'package:ecomerce/core/styles/customTextFormStyle.dart';
import 'package:ecomerce/core/utils/app_strings.dart';
import 'package:ecomerce/core/utils/cache_helper.dart';
import 'package:ecomerce/features/cart/data/model/cart_model.dart';
import 'package:ecomerce/features/cart/presentation/cubit/cubit/cart_cubit.dart';
import 'package:ecomerce/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:ecomerce/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared/widgets/custom_title.dart';
import '../../../../core/shared/widgets/shared_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/di.dart';
import '../../../auth/presentation/widgets/custom_separation_widget.dart';

class MyAllCarts extends StatelessWidget {
  const MyAllCarts({super.key});

  @override
  Widget build(BuildContext context) {
    // di<CartCubit>().getCartDataFromSharedPref();
    return Scaffold(
      body: SafeArea(
          child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is SuccessUploadProductToCart) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(AppStrings.successUploadProductToCart),
            ));
            CacheHelper.removeData(key: "productsInCart");
            di<CartCubit>().myAllCartProducts.clear();
            di<CartCubit>().myAllCartProducts.length = 0;
            di<CartCubit>().productsInCart.clear();
            Navigator.of(context).pop();
          } else if (state is SuccessDeleteProductFromCart) {
            print(di<CartCubit>().myAllCartProducts.length);
            di<CartCubit>().getCartDataFromSharedPref();
          }
        },
        builder: (context, state) {
          if (state is LoadingGetAllMyCarts ||
              state is LoadingGetAllProductOfEachMyCarts ||
              state is LoadingUploadProductToCart) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              children: [
                CustomAppBarWidget(isHome: false),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 10.h,
                ),
                buildListMyCartProducts(context),
                di<CartCubit>().productsInCart.length != 0
                    ? Container(
                        margin: EdgeInsets.only(bottom: 20.h, top: 10),
                        child: SharedButton(
                          backgroundColor: AppColors.primaryColor,
                          title: AppStrings.addToCart,
                          onPressed: () async {
                            di<CartCubit>().uploadProductToCartAPI();
                          },
                          textTitleSize: 12.sp,
                          textTitleStyle:
                              btnTextStyle.copyWith(fontSize: 15.sp),
                          borderRaduis: 10,
                          width: 305.w,
                          height: 50.h,
                          color: AppColors.whiteColor,
                        ),
                      )
                    : Container()
              ],
            );
          }
        },
      )),
    );
  }

  buildListMyCartProducts(BuildContext context) => Expanded(
        child: di<CartCubit>().productsInCart.length != 0
            ? ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: di<CartCubit>().productsInCart.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.lotionColor,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: MediaQuery.of(context).size.width - 20.w,
                        height: MediaQuery.of(context).size.height / 4,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 150.h,
                                      width: 150.h,
                                      padding: EdgeInsets.all(20),
                                      child: Image.network(di<CartCubit>()
                                              .myAllCartProducts[index]
                                              .image
                                              .toString()
                                          //new Icon(Icons.error),
                                          ),
                                    )),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Flexible(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DefaultTitle(
                                          text: di<CartCubit>()
                                              .myAllCartProducts[index]
                                              .title
                                              .toString(),
                                          maxLine: 1,
                                          style: subHeadingTextStyle,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        DefaultTitle(
                                          text: di<CartCubit>()
                                              .myAllCartProducts[index]
                                              .description
                                              .toString(),
                                          maxLine: 1,
                                          style: hintTextStyle,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        DefaultTitle(
                                          text: di<CartCubit>()
                                                  .myAllCartProducts[index]
                                                  .price
                                                  .toString() +
                                              ' EGP',
                                          maxLine: 1,
                                          style: subHeadingTextBlackStyle,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            DefaultTitle(
                                              text: 'Quantity',
                                              maxLine: 1,
                                              style:
                                                  subHeadingTextStyle.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 50.0),
                                              child: DefaultTitle(
                                                text: di<CartCubit>()
                                                    .productsInCart[index]
                                                    .ProductQuantity
                                                    .toString(),
                                                maxLine: 1,
                                                style: subHeadingTextStyle
                                                    .copyWith(
                                                        color: Colors.red),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: SharedButton(
                                                  backgroundColor:
                                                      AppColors.primaryColor,
                                                  title: AppStrings.delete,
                                                  onPressed: () async {
                                                    di<CartCubit>()
                                                        .deleteSpecificItem(di<
                                                                CartCubit>()
                                                            .myAllCartProducts[
                                                                index]
                                                            .id!);
                                                  },
                                                  textTitleSize: 12.sp,
                                                  textTitleStyle:
                                                      btnTextStyle.copyWith(
                                                          fontSize: 15.sp),
                                                  borderRaduis: 10,
                                                  width: 40.w,
                                                  height: 10.h,
                                                  color: AppColors.whiteColor,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: SharedButton(
                                                  backgroundColor:
                                                      AppColors.primaryColor,
                                                  title: AppStrings.edit,
                                                  onPressed: () async {
                                                    di<CartCubit>()
                                                        .editQuantityController
                                                        .text = '';
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Text(AppStrings
                                                                .addQuantityYouWant),
                                                            content:
                                                                TextFormField(
                                                              controller: di<
                                                                      CartCubit>()
                                                                  .editQuantityController,
                                                              decoration:
                                                                  InputDecoration(
                                                                      hintText:
                                                                          "Enter quantity"),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: Text(
                                                                    'CANCEL'),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                              TextButton(
                                                                child:
                                                                    Text('OK'),
                                                                onPressed: () {
                                                                  di<CartCubit>().editSpecificItem(di<
                                                                          CartCubit>()
                                                                      .myAllCartProducts[
                                                                          index]
                                                                      .id!);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                  },
                                                  textTitleSize: 12.sp,
                                                  textTitleStyle:
                                                      btnTextStyle.copyWith(
                                                          fontSize: 15.sp),
                                                  borderRaduis: 10,
                                                  width: 40.w,
                                                  height: 10.h,
                                                  color: AppColors.whiteColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ))
            : Container(
                child: Center(child: Text('There is no products in your cart')),
              ),
      );
}
