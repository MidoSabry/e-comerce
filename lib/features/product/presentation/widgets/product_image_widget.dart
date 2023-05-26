import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:ecomerce/features/product/presentation/cubit/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/di.dart';
import '../../../../core/styles/customTextFormStyle.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import 'headerText.dart';

class ProductPhotoWidget extends StatelessWidget {
  const ProductPhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
            height: 250.h,
            width: 250.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.whiteColor,
            ),
            child: di<ProductCubit>().selectedImagePath == ''
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: DottedBorder(
                        color: AppColors.grayColor,
                        strokeWidth: 2,
                        dashPattern: [
                          5,
                          5,
                        ],
                        child: Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  HeaderText(
                                      headerText: AppStrings.product_picture,
                                      headerTextStyle: TextBlackStyle),
                                  SizedBox(height: 7.h),
                                  Expanded(
                                    child: HeaderText(
                                        headerText: AppStrings.usePdf,
                                        headerTextStyle: hintTextStyle.copyWith(
                                            fontSize: 12.sp)),
                                  ),
                                  HeaderText(
                                      headerText: AppStrings.youMustUploadPhoto,
                                      headerTextStyle: subHeadingTextBlackStyle
                                          .copyWith(fontSize: 11.sp)),
                                ],
                              ),
                            ))),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(
                        File(di<ProductCubit>().selectedImagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ));
      },
    );
  }
}
