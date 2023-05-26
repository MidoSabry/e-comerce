import 'package:ecomerce/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/di.dart';

class CustomAppBarWidget extends StatelessWidget {
  CustomAppBarWidget({super.key, required this.isHome});

  bool isHome = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(top: 20),
          child: isHome == true
              ? IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.services,
                    );
                  },
                  icon: Icon(
                    Icons.person,
                    color: AppColors.primaryColor,
                    size: 30.sp,
                  ))
              : IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      border: Border.all(
                        color: AppColors.grayColor,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                        weight: 2,
                      ),
                    ),
                  )),
        ),
        Container(
          width: 250.w,
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
              controller: di<HomeCubit>().textSearchController,
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
                di<HomeCubit>().productsSearch(index);
              }),
        ),
        Container(
            padding: EdgeInsets.only(top: 20),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_cart,
                  color: AppColors.primaryColor,
                  size: 30.sp,
                ))),
      ],
    );
  }
}
