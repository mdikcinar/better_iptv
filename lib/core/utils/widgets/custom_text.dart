// ignore: must_be_immutable
import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../utils.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  final String? text;
  double? textSize;
  final Color? textColor;
  final bool underlined;
  final bool bold;
  final bool centerText;
  CustomText(this.text, {Key? key, this.textColor, this.underlined = false, this.bold = false, this.centerText = false})
      : super(key: key) {
    textSize = Utils.normalTextSize;
  }
  CustomText.extraLow(
    this.text, {
    Key? key,
    this.textColor,
    this.underlined = false,
    this.bold = false,
    this.centerText = false,
  }) : super(key: key) {
    textSize = Utils.extraLowTextSize;
  }
  CustomText.low(
    this.text, {
    Key? key,
    this.textColor,
    this.underlined = false,
    this.bold = false,
    this.centerText = false,
  }) : super(key: key) {
    textSize = Utils.lowTextSize;
  }
  CustomText.high(
    this.text, {
    Key? key,
    this.textColor,
    this.underlined = false,
    this.bold = false,
    this.centerText = false,
  }) : super(key: key) {
    textSize = Utils.highTextSize;
  }
  CustomText.extraHigh(
    this.text, {
    Key? key,
    this.textColor,
    this.underlined = false,
    this.bold = false,
    this.centerText = false,
  }) : super(key: key) {
    textSize = Utils.extraHighTextSize;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: TextStyle(
        fontSize: textSize ?? Utils.normalTextSize,
        color: textColor ?? getTextColor,
        decoration: underlined ? TextDecoration.underline : null,
        fontWeight: bold ? FontWeight.bold : null,
      ),
      textAlign: centerText ? TextAlign.center : null,
    );
  }
}
