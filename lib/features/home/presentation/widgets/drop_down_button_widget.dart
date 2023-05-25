import 'package:ecomerce/core/styles/customTextFormStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared/widgets/custom_title.dart';
import '../../../../core/utils/app_colors.dart';



class DropDownButtonWidget extends StatelessWidget {
  DropDownButtonWidget(
      {Key? key,
      this.w,
      required this.id,
      required this.onChange,
      required this.isExistBorder,
      this.itemList})
      : super(key: key);
  var id;
  final List? itemList;
  double? w = double.infinity;
  final Function onChange;
  bool isExistBorder = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 20.0),
      //padding: EdgeInsets.symmetric(horizontal: 20.0),
      alignment: Alignment.center,
      width: w,
      height: 70.h,
      decoration: BoxDecoration(
          border: Border.all(
              color: isExistBorder == true ? AppColors.blackColor : Colors.transparent,
              width: isExistBorder == true ? 0.0 : 0.0,
              style: isExistBorder == true
                  ? BorderStyle.solid
                  : BorderStyle.none)),
      child: DropdownButton(
        isExpanded: true,
        underline: isExistBorder == false
            ? SizedBox(
                height: 5.0,
                child: Divider(
                  thickness: 2.0,
                ))
            : Container(),
        items: List.generate(
          itemList!.length,
          (index) => DropdownMenuItem(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: DefaultTitle(
                text: itemList![index].toString(),
                style: subHeadingTextBlackStyle,
              ),
            ),
            value: itemList![index],
          ),
        ),
        onChanged: (v) => onChange(v),
        value: id,
      ),
    );
  }
}
