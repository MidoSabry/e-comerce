import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTitle extends StatelessWidget {
  DefaultTitle(
      {Key? key,
      required this.text,
      required this.style,
      this.align,
      this.textAlign,
      this.maxLine = 3})
      : super(key: key);
  final String text;
  final int maxLine;
  final TextStyle style;
  TextAlign? textAlign = TextAlign.center;
  Alignment? align = Alignment.centerLeft;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: align,
      child: Text(
        text,
        style: style,
        textAlign: textAlign,
        maxLines: maxLine,
        textScaleFactor: 1.0,
        // overflow: TextOverflow.ellipsis,
        overflow: TextOverflow.clip,
      ),
    );
  }
}
