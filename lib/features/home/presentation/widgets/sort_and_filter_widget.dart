import 'package:ecomerce/core/styles/customTextFormStyle.dart';
import 'package:ecomerce/core/utils/app_colors.dart';
import 'package:ecomerce/core/utils/app_strings.dart';
import 'package:ecomerce/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared/widgets/custom_title.dart';
import '../../../../core/utils/di.dart';
import '../../../auth/presentation/widgets/custom_separation_widget.dart';
import 'drop_down_button_widget.dart';

class SortAndFilterWidget extends StatefulWidget {
  SortAndFilterWidget({
    Key? key,
    required this.url,

    // required this.typeOfProductsToSort,
  }) : super(key: key);

  int initialIndex = 0;
  String url;

  @override
  State<SortAndFilterWidget> createState() => _SortAndFilterWidgetState();
}

class _SortAndFilterWidgetState extends State<SortAndFilterWidget> {
  TabController? bottomTabController;

  String indexOfSort = AppStrings.defoult_sort;

  //range of price
  var selectRating = RangeValues(0, 7);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSeparationWidget(size: 2),
        Row(
          children: [
            Expanded(
                child: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return Container(
                  height: MediaQuery.of(context).size.height / 11.8,
                  //alignment: Alignment.center,
                  child: DropDownButtonWidget(
                      itemList: HomeCubit.sortItems,
                      isExistBorder: true,
                      id: di<HomeCubit>().selectSortItem,
                      onChange: (x) {
                        indexOfSort = x;
                        di<HomeCubit>().changeValueOfDropDownListOfSort(x);

                        di<HomeCubit>().getProductsAfterSort(
                            widget.url, di<HomeCubit>().kindSort);

                        // di<CategoriesCubit>().getCatalogueProducts(
                        //     sort: di<CategoriesCubit>().selectSortItem);
                      }),
                );
              },
            )),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      //
                    },
                    child: Row(
                      children: [
                        DefaultTitle(
                          text: AppStrings.filter_txt,
                          style: subHeadingTextStyle,
                        ),
                        Spacer(),
                        Icon(
                          Icons.tune,
                          size: 25.0,
                          color: AppColors.blackColor,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        CustomSeparationWidget(
          size: 2,
        ),
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
