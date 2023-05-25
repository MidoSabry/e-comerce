import 'package:ecomerce/core/shared/widgets/custom_title.dart';
import 'package:ecomerce/core/styles/customTextFormStyle.dart';
import 'package:ecomerce/core/utils/app_colors.dart';
import 'package:ecomerce/core/utils/app_strings.dart';
import 'package:ecomerce/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                          )
                        ],
                      ),
                    ),
                  ));
            }
          },
        ));
  }
}
