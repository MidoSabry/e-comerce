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

  //size data
  List<String> sizes = [
    "One_Size",
    "Free_Size",
    "XS",
    "S",
    "M",
    "L",
    "XL",
    "2XL",
    "3XL",
    "1.5",
    "2",
    "3",
    "4",
    "6",
    "8",
    "9",
    "10",
    "12",
    "14",
    "29",
    "39",
    "75",
    "283",
    "Xl",
    "30",
    "37",
    "38",
    "40",
    "41",
    "42",
    "43",
    "44",
    "45",
    "330*331",
    "60",
    "170",
    "250",
    "500",
  ];

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

                        di<HomeCubit>().getProductsAfterSort(widget.url, di<HomeCubit>().kindSort);

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
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ), // Rounded RectangleBorder
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: Container(
                                        // width: MediaQuery.of(context).size.width,
                                        height: 400.h,
                                        child: DefaultTabController(
                                          initialIndex: widget.initialIndex,
                                          length: 4,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 25,
                                                      horizontal: 10),
                                              child: Scaffold(
                                                  resizeToAvoidBottomInset:
                                                      false,
                                                  // appBar: TabBar(
                                                  //   tabs: [
                                                  //     Text(
                                                  //       AppStrings.brand_txt
                                                  //           .tr(),
                                                  //       style: textThemeData
                                                  //           .bodyText1,
                                                  //     ),
                                                  //     Text(
                                                  //       AppStrings
                                                  //           .color_filter_txt
                                                  //           .tr(),
                                                  //       style: textThemeData
                                                  //           .bodyText1,
                                                  //     ),
                                                  //     Text(
                                                  //       AppStrings
                                                  //           .size_filter_txt
                                                  //           .tr(),
                                                  //       style: textThemeData
                                                  //           .bodyText1,
                                                  //     ),
                                                  //     Text(
                                                  //       AppStrings.price.tr(),
                                                  //       style: textThemeData
                                                  //           .bodyText1,
                                                  //     ),
                                                  //   ],
                                                  //   onTap: (x) {
                                                  //     if (x == 0) {
                                                  //       di<CategoriesCubit>()
                                                  //           .getListOfBrands();
                                                  //     } else if (x == 1) {
                                                  //       di<CategoriesCubit>()
                                                  //           .getListOfColors();
                                                  //     }
                                                  //   },
                                                  // ),
                                                  body: Center()
                                                  //  TabBarView(
                                                  //   physics:
                                                  //       NeverScrollableScrollPhysics(),
                                                  //   controller:
                                                  //       bottomTabController,
                                                  //   children: <Widget>[
                                                  //     // basicBottomSheet(context),
                                                  //     BrandBottomSheet(context),
                                                  //     ColorBottomSheet(context),
                                                  //     SizeBottomSheet(
                                                  //         context, setState),
                                                  //     PriceBottomSheet(
                                                  //         context, setState)
                                                  //   ],
                                                  // )

                                                  )),
                                        )),
                                  ),
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //       color: white,
                                  //       border: Border.all(width: 0.0)),
                                  //   constraints:
                                  //       BoxConstraints(maxHeight: 70.0.h),
                                  //   padding:
                                  //       EdgeInsets.symmetric(horizontal: 15.0),
                                  //   child: Column(
                                  //     children: [
                                  //       //_buildTotalWidget(),
                                  //       SizedBox(
                                  //         height: 10.0,
                                  //       ),
                                  //       BlackButtonWidget(
                                  //         title: AppStrings.filter_txt.tr(),
                                  //         onPress: () {
                                  //           di<CategoriesCubit>()
                                  //               .filterDaTaOperations();

                                  //           navigatePop(context: context);
                                  //           // print(di<CategoriesCubit>()
                                  //           //     .brandSelectedData);

                                  //           // print(di<CategoriesCubit>()
                                  //           //     .colorSelectedData);

                                  //           // print(di<CategoriesCubit>()
                                  //           //     .sizeSelectedData);
                                  //         },
                                  //       ),
                                  //     ],
                                  //   ),
                                  // )
                                ],
                              );
                            });
                          });
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

  //Brand BottomSheet
  // Widget BrandBottomSheet(BuildContext context) {
  //   // di<CategoriesCubit>().getListOfBrands();

  //   return BlocConsumer<CategoriesCubit, CategoriesState>(
  //     listener: (context, state) {
  //       // TODO: implement listener
  //     },
  //     builder: (context, state) {
  //       if (state is LoadingToGetBrandsList ||
  //           state is startSearchColorInList) {
  //         return RvverProgressIndicator();
  //       } else {
  //         return Column(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
  //               child: Container(
  //                 height: 45.h,
  //                 child: TextField(
  //                     controller:
  //                         di<CategoriesCubit>().textBrandSearchController,
  //                     decoration: InputDecoration(
  //                         border: OutlineInputBorder(
  //                             borderRadius: BorderRadius.circular(15),
  //                             borderSide: BorderSide(color: Colors.grey)),
  //                         prefixIcon: Icon(Icons.search)),
  //                     onChanged: (index) {
  //                       di<CategoriesCubit>().brandsSearch(index);
  //                     }),
  //               ),
  //             ),
  //             Expanded(
  //               child: SingleChildScrollView(
  //                 physics: BouncingScrollPhysics(),
  //                 child: ListView(
  //                     physics: NeverScrollableScrollPhysics(),
  //                     shrinkWrap: true,
  //                     children: List.generate(
  //                         di<CategoriesCubit>().brandsList.length, (int index) {
  //                       return Padding(
  //                         padding: const EdgeInsets.all(10),
  //                         child: InkWell(
  //                           child: Row(
  //                             children: [
  //                               Icon(
  //                                 Icons.check,
  //                                 // color: isCheck == false ? Colors.grey : Colors.black,
  //                                 color: di<CategoriesCubit>()
  //                                         .brandSelectedData
  //                                         .any((element) => element.values
  //                                             .contains(di<CategoriesCubit>()
  //                                                 .brandsList[index]['id']))
  //                                     ? Colors.black
  //                                     : Colors.grey,
  //                               ),
  //                               SizedBox(
  //                                 width: 20,
  //                               ),
  //                               Text(di<CategoriesCubit>()
  //                                   .brandsList[index]['name']
  //                                   .toString()),
  //                             ],
  //                           ),
  //                           onTap: () {
  //                             di<CategoriesCubit>().selectBrands(
  //                                 di<CategoriesCubit>().brandsList[index]
  //                                     ['id']);
  //                           },
  //                         ),
  //                       );
  //                     })),
  //               ),
  //             )
  //           ],
  //         );
  //       }
  //     },
  //   );
  // }

  // //Color bottomsheet
  // Widget ColorBottomSheet(BuildContext context) {
  //   //di<CategoriesCubit>().getListOfColors();

  //   return BlocConsumer<CategoriesCubit, CategoriesState>(
  //     listener: (context, state) {
  //       // TODO: implement listener
  //     },
  //     builder: (context, state) {
  //       if (state is LoadingToGetColorsList ||
  //           state is startSearchColorInList) {
  //         return RvverProgressIndicator();
  //       } else {
  //         return Column(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
  //               child: Container(
  //                 height: 45.h,
  //                 child: TextField(
  //                     controller: di<CategoriesCubit>().colorSearchController,
  //                     decoration: InputDecoration(
  //                         border: OutlineInputBorder(
  //                             borderRadius: BorderRadius.circular(15),
  //                             borderSide: BorderSide(color: Colors.grey)),
  //                         prefixIcon: Icon(Icons.search)),
  //                     onChanged: (index) {
  //                       di<CategoriesCubit>().searchColorInList(index);
  //                     }),
  //               ),
  //             ),
  //             Expanded(
  //               child: SingleChildScrollView(
  //                 physics: BouncingScrollPhysics(),
  //                 child: ListView(
  //                     physics: NeverScrollableScrollPhysics(),
  //                     shrinkWrap: true,
  //                     children: List.generate(
  //                         di<CategoriesCubit>().colorsList.length, (int index) {
  //                       return Padding(
  //                         padding: const EdgeInsets.all(10),
  //                         child: InkWell(
  //                           child: Row(
  //                             children: [
  //                               Icon(
  //                                 Icons.check,
  //                                 color: di<CategoriesCubit>()
  //                                         .colorSelectedData
  //                                         .any((element) => element.values
  //                                             .contains(di<CategoriesCubit>()
  //                                                 .colorsList[index]['hex']))
  //                                     ? Colors.black
  //                                     : Colors.grey,
  //                               ),
  //                               SizedBox(
  //                                 width: 20,
  //                               ),
  //                               Text(di<CategoriesCubit>().colorsList[index]
  //                                   ['name']),
  //                             ],
  //                           ),
  //                           onTap: () {
  //                             di<CategoriesCubit>().selectColors(
  //                                 di<CategoriesCubit>().colorsList[index]
  //                                     ['hex']);
  //                           },
  //                         ),
  //                       );
  //                     })),
  //               ),
  //             )
  //           ],
  //         );
  //       }
  //     },
  //   );
  // }

  // //Size bottomSheet
  // Widget SizeBottomSheet(BuildContext context, StateSetter setState2) {
  //   return SingleChildScrollView(
  //     physics: const BouncingScrollPhysics(),
  //     child: Column(
  //       children: [
  //         SizedBox(
  //           height: 10,
  //         ),
  //         ListView(
  //             physics: NeverScrollableScrollPhysics(),
  //             shrinkWrap: true,
  //             children: List.generate(sizes.length, (int index) {
  //               return Padding(
  //                 padding: const EdgeInsets.all(10),
  //                 child: InkWell(
  //                   child: Row(
  //                     children: [
  //                       Icon(
  //                         Icons.check,
  //                         color: di<CategoriesCubit>().sizeSelectedData.any(
  //                                 (element) =>
  //                                     element.values.contains(sizes[index]))
  //                             ? Colors.black
  //                             : Colors.grey,
  //                       ),
  //                       SizedBox(
  //                         width: 20,
  //                       ),
  //                       Text(
  //                         sizes[index],
  //                         //style: textThemeData.bodyText1,
  //                       ),
  //                     ],
  //                   ),
  //                   onTap: () {
  //                     setState2(() {
  //                       di<CategoriesCubit>().selectSizes(sizes[index]);
  //                     });
  //                   },
  //                 ),
  //               );
  //             }))
  //       ],
  //     ),
  //   );
  // }

  // //Price bottomsheet
  // Widget PriceBottomSheet(BuildContext context, StateSetter setState2) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //         height: 90.0,
  //         color: white,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Container(
  //               padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
  //               child: Row(
  //                 children: [
  //                   DefaultTitle(
  //                       text: '${selectRating.start.round()} EGP',
  //                       style: textThemeData.bodyText2!.copyWith(color: black)),
  //                   Spacer(
  //                     flex: 1,
  //                   ),
  //                   DefaultTitle(
  //                       text: '${selectRating.end.round()} EGP',
  //                       style: textThemeData.bodyText2!.copyWith(color: black))
  //                 ],
  //               ),
  //             ),
  //             RangeSlider(
  //                 divisions: 15,
  //                 min: 0.0,
  //                 max: 5000.0,
  //                 values: selectRating,
  //                 onChanged: (newRating) {
  //                   setState2(() {
  //                     di<CategoriesCubit>().heighPrice =
  //                         selectRating.end.round();
  //                     di<CategoriesCubit>().lowPrice =
  //                         selectRating.start.round();

  //                     selectRating = newRating;
  //                   });
  //                 }),
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }
}
