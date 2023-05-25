import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomerce/core/styles/customTextFormStyle.dart';
import 'package:ecomerce/core/utils/app_colors.dart';
import 'package:ecomerce/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/di.dart';
import '../widgets/custom_single_product_widget.dart';
import '../widgets/home_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 286.w,
                height: 48.h,
                margin: EdgeInsets.only(top: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.lotionColor,
                  border: Border.all(
                    color: AppColors.lotionColor,
                    width: 1,
                  ),
                ),
                child: TextFormField(
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppStrings.search,
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 30,
                        color: AppColors.searchIconColor,
                      ),
                    ),
                    onChanged: (index) {
                      // di<SignupCoachCubit>().currencySearch(index);
                    }),
              ),
              SizedBox(
                height: 20.h,
              ),
              BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is LoadingGetCategoriesList) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return SizedBox(
                      height: 60.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: di<HomeCubit>().categoriesList.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: GestureDetector(
                                child: Container(
                                  color: AppColors.primaryColor,
                                  width: 200.w,
                                  height: 60.h,
                                  child: Center(
                                    child: Text(
                                      di<HomeCubit>().categoriesList[i],
                                      style: subHeadingTextStyle.copyWith(
                                          color: AppColors.whiteColor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                onTap: () {},
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              HomeWidgets.builFirstSlider(),
              Container(
                color: AppColors.lotionColor,
                height: 30.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.suggestionForYou,
                      style:
                          textButtonStyle.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(AppStrings.seeAll,
                        style: textButtonStyle.copyWith(
                          decoration: TextDecoration.underline,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is LoadingGetProductsList) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return SizedBox(
                      height: 300.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: di<HomeCubit>().productList.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: GestureDetector(
                                child: Container(
                                    // color: AppColors.primaryColor,
                                    decoration: BoxDecoration(
                                      color: AppColors.lotionColor,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    width: 150.w,
                                    height: 350.h,
                                    child: CustomSingleProductWidget(
                                      itemsList: di<HomeCubit>().productList,
                                      index: i,
                                    )),
                                onTap: () {},
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
