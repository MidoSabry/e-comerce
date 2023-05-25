
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({Key? key, required this.icon, required this.press})
      : super(key: key);

  final String icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber,
      child: GestureDetector(
        onTap: press,
        child: Image.asset(
          icon,
          width: 100.w,
          //height: getProportionateScreenHeight(80.0),
        ),
      ),
    );
  }
}
