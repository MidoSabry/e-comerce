import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomerce/core/styles/customTextFormStyle.dart';
import 'package:ecomerce/core/utils/app_colors.dart';
import 'package:ecomerce/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:ecomerce/features/home/presentation/screens/all_products_screen.dart';
import 'package:ecomerce/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/app_routes.dart';
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
          child: Container(
            margin: EdgeInsets.only(bottom: 50.h),
            child: Column(
              children: [
                CustomAppBarWidget(isHome: true),
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
                              child: GestureDetector(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
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
                                ),
                                onTap: () {
                                  di<HomeCubit>().getProductsOfEachCategory(
                                      di<HomeCubit>()
                                          .categoriesList[i]
                                          .toString());
                                  Navigator.pushNamed(
                                    context,
                                    Routes.productsList,
                                    arguments: di<HomeCubit>()
                                        .categoriesList[i]
                                        .toString(),
                                  );
                                },
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
                        style: textButtonStyle.copyWith(
                            fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        child: Text(AppStrings.seeAll,
                            style: textButtonStyle.copyWith(
                              decoration: TextDecoration.underline,
                            )),
                        onTap: () {
                          di<HomeCubit>().getAllProductsList();
                          Navigator.pushNamed(
                            context,
                            Routes.productsList,
                            arguments: 'All products',
                          );
                        },
                      )
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
                        height: MediaQuery.of(context).size.height / 2.h,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: di<HomeCubit>().limetedProductList.length,
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
                                        itemsList:
                                            di<HomeCubit>().limetedProductList,
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
      ),
    );
  }
}
