import 'package:ecomerce/core/shared/widgets/custom_title.dart';
import 'package:ecomerce/core/styles/customTextFormStyle.dart';
import 'package:ecomerce/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:ecomerce/features/home/presentation/widgets/custom_single_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/end_points.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/di.dart';
import '../../data/repositories/models/products.dart';
import '../cubit/cubit/home_cubit.dart';
import '../widgets/sort_and_filter_widget.dart';

class AllProductsScreen extends StatelessWidget {
  AllProductsScreen({super.key, required this.nameOfScreen});

  String nameOfScreen;
  @override
  Widget build(BuildContext context) {
    di<HomeCubit>().selectSortItem = HomeCubit.sortItems.first;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBarWidget(isHome: false),
            SortAndFilterWidget(
                url: nameOfScreen == 'All products'
                    ? EndPoints.getProducts
                    : '${EndPoints.getProductsOfEachCategory}/$nameOfScreen'),
            nameOfScreen != 'All products'
                ? Container(
                    width: double.infinity,
                    color: AppColors.lotionColor,
                    child: Center(
                      child: DefaultTitle(
                          text: nameOfScreen, style: headingTextStyle),
                    ))
                : Container(),
            BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is LoadingGetProductsList) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          di<HomeCubit>().allProductsList.length != 0
                              ? GridView.count(
                                  physics: const NeverScrollableScrollPhysics(),
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width > 768
                                          ? 1 / 1.7
                                          : 1 / 1.9,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 1.h,
                                  // mainAxisSpacing: 1.h,

                                  shrinkWrap: true,
                                  children: List.generate(
                                    di<HomeCubit>().allProductsList.length,
                                    (index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: GestureDetector(
                                            child: Container(
                                                // color: AppColors.primaryColor,
                                                decoration: BoxDecoration(
                                                  color: AppColors.lotionColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                width: 150.w,
                                                height: 350.h,
                                                child:
                                                    CustomSingleProductWidget(
                                                  itemsList: di<HomeCubit>()
                                                      .allProductsList,
                                                  index: index,
                                                )),
                                            onTap: () {},
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      1.3.h,
                                  child: Center(
                                      child: Text(
                                    AppStrings.productsIsNotAvailableNow,
                                    style: subHeadingTextStyle,
                                  )),
                                ),
                        ],
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
