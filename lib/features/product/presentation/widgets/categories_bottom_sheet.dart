import 'package:ecomerce/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:ecomerce/features/product/presentation/cubit/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/di.dart';
import '../../../auth/presentation/widgets/custom_separation_widget.dart';

class CategoriesBottomSheet extends StatelessWidget {
  CategoriesBottomSheet({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45.0),
      child: Column(
        children: [
          SizedBox(
            height: 18.h,
          ),
          CustomSeparationWidget(size: 4.h, w: 34.w),
          SizedBox(
            height: 29.h,
          ),
         
         
          Expanded(
            child: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: di<HomeCubit>().categoriesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(di<HomeCubit>().categoriesList[index]),
                      onTap: () {
                      
                          di<ProductCubit>().selectCategoryFunc(index);

                          Navigator.pop(context);
                      },
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
