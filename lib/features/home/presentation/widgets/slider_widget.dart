import 'package:ecomerce/core/utils/app_colors.dart';
import 'package:ecomerce/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/di.dart';
import 'custom_slider_single_product_widget.dart';

class SlideWidget extends StatelessWidget {
  int? index;
  SlideWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            height: MediaQuery.of(context).size.height / 1.8,
            child: CustomSliderSingleProductWidget(
              isDark: false,
              maxWidth: double.infinity,
              maxHeight: double.infinity,
              fit: BoxFit.contain,
              sliderHeight: MediaQuery.of(context).size.height / 1.3,
              image: [di<HomeCubit>().product.image],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: _buildIconBack(context),
        )
      ],
    );
  }

  _buildIconBack(context) => IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          // AppPreferences().appLanguage != 'ar'
          //     ?
          Icons.arrow_back_ios,
          // : Icons.arrow_forward_ios,
          size: 27.0,
          color: AppColors.blackColor,
        ),
      );
}
