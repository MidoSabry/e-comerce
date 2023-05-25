import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomerce/core/styles/customTextFormStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared/widgets/custom_title.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/repositories/models/products.dart';

class CustomSingleProductWidget extends StatefulWidget {
  CustomSingleProductWidget({required this.itemsList, required this.index});

  int index;
  List<Products> itemsList;

  @override
  State<CustomSingleProductWidget> createState() =>
      _CustomSingleProductWidgetState();
}

class _CustomSingleProductWidgetState extends State<CustomSingleProductWidget> {
  bool iconIsFav = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            // color: Color(0x15527148),
            // child: Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildProductImage(context, widget.itemsList[widget.index]),
                SizedBox(
                  height: 5.h,
                ),
                buildProductDetails(context, widget.itemsList[widget.index]),
              ],
            ),
            // ),
          ),
        ));
  }

  /////Image/////////////
  buildProductImage(context, productIndex) => Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: (2 / 3),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Image.network(
                    widget.itemsList[widget.index].image.toString(),

                    //new Icon(Icons.error),
                  ),
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Center(
                        child: Text(
                      widget.itemsList[widget.index].rating!.rate.toString(),
                      style: btnTextStyle.copyWith(color: AppColors.whiteColor),
                    ))),
              )
            ],
          )
        ],
      );

//////////details////////////
  buildProductDetails(context, productIndex) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildRvverBase(context, productIndex),
        DefaultTitle(
          text: widget.itemsList[widget.index].description.toString(),
          maxLine: 1,
          style: hintTextStyle,
        ),
        Row(children: [
          Container(
              alignment: Alignment.bottomRight,
              child: DefaultTitle(
                  textAlign: TextAlign.center,
                  text:
                      widget.itemsList[widget.index].price.toString() + ' EGP',
                  style: subHeadingTextStyle)),
          SizedBox(width: 5.w),
          Spacer(),
          Container(
              alignment: Alignment.topRight,
              child: InkWell(
                  child: iconIsFav
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_outline),
                  onTap: () {
                    setState(() {
                      iconIsFav = !iconIsFav;
                    });
                  })),
        ]),
      ])));

  // ),

  _buildRvverBase(context, dynamic productIndex) => Row(
        children: [
          Expanded(
            child: Container(
              // width: double.infinity,
              child: DefaultTitle(
                text: widget.itemsList[widget.index].title.toString(),
                maxLine: 1,
                style: subHeadingTextStyle,
              ),
            ),
          ),
        ],
      );
}