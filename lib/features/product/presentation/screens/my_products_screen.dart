import 'package:ecomerce/core/styles/customTextFormStyle.dart';
import 'package:ecomerce/core/utils/app_colors.dart';
import 'package:ecomerce/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:ecomerce/features/product/presentation/cubit/cubit/product_cubit.dart';
import 'package:ecomerce/features/product/presentation/screens/my_single_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/shared/widgets/custom_title.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/di.dart';
import '../../../auth/presentation/widgets/custom_separation_widget.dart';
import '../../../home/presentation/cubit/cubit/home_cubit.dart';

class MyProducts extends StatelessWidget {
  const MyProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: BlocConsumer<ProductCubit, ProductState>(
            listener: (context, state) {
              if (state is SuccessDeleteProduct) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('delete done!'),
                ));
              } else if (state is ErrorToDeleteProduct) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(AppStrings.error_message),
                ));
              }
            },
            builder: (context, state) {
              if (state is LoadingDeleteProduct) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomAppBarWidget(isHome: false),
                      buildListMyProducts(context),
                    ],
                  ),
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () => {
            Navigator.pushNamed(context, Routes.mySingleProduct,
                arguments: {'isAddProduct': true, 'productId': 0})
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }

  buildListMyProducts(BuildContext context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: InkWell(
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 24.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                  ),
                  onTap: () {
                    /////delete here////
                    di<ProductCubit>().deleteProduct(
                        di<HomeCubit>().limetedProductList[index].id);
                  }),
            ),
            InkWell(
              onTap: () {
                ////////Navigate to update here/////////////
                Navigator.pushNamed(context, Routes.mySingleProduct,
                    arguments: {
                      'isAddProduct': false,
                      'productId': di<HomeCubit>().limetedProductList[index].id
                    });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: Container(
                        height: 150.h,
                        width: 150.h,
                        padding: EdgeInsets.all(20),
                        child: Image.network(di<HomeCubit>()
                                .limetedProductList[index]
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
                      width: MediaQuery.of(context).size.width / 1.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultTitle(
                            text: di<HomeCubit>()
                                .limetedProductList[index]
                                .title
                                .toString(),
                            maxLine: 1,
                            style: subHeadingTextStyle,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          DefaultTitle(
                            text: di<HomeCubit>()
                                .limetedProductList[index]
                                .description
                                .toString(),
                            maxLine: 1,
                            style: hintTextStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DefaultTitle(
                            text: di<HomeCubit>()
                                .limetedProductList[index]
                                .price
                                .toString(),
                            maxLine: 1,
                            style: subHeadingTextBlackStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DefaultTitle(
                            text: di<HomeCubit>()
                                .limetedProductList[index]
                                .category
                                .toString(),
                            maxLine: 1,
                            style: subHeadingTextStyle,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        itemCount: 5,
        separatorBuilder: (BuildContext context, int index) =>
            CustomSeparationWidget(size: 2),
      );
}
