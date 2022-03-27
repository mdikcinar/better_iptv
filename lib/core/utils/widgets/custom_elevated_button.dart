import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/colors.dart';
import '../utils.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double? borderRadius;
  final double? minimumWith;
  final double? minimumHeight;
  final double? fontSize;
  final EdgeInsets? padding;
  final Color? borderColor;
  final bool isActive;
  final void Function()? onPressed;
  const CustomElevatedButton(
      {Key? key,
      required this.child,
      this.onPressed,
      this.overlayColor,
      this.borderColor,
      this.borderRadius,
      this.minimumWith,
      this.minimumHeight,
      this.padding,
      this.fontSize,
      this.backgroundColor,
      this.isActive = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isActive ? onPressed : null,
      child: child,
      style: ButtonStyle(
        overlayColor: overlayColor != null
            ? MaterialStateProperty.all<Color>(HSLColor.fromColor(overlayColor!).withLightness(0.25).toColor())
            : MaterialStateProperty.all<Color>(HSLColor.fromColor(Get.theme.primaryColor).withLightness(0.25).toColor()),
        backgroundColor: backgroundColor != null
            ? MaterialStateProperty.all<Color>(backgroundColor!)
            : MaterialStateProperty.all<Color>(isActive ? Get.theme.primaryColor : Colors.transparent),
        minimumSize: MaterialStateProperty.all<Size>(
          Size(minimumWith ?? 1, minimumHeight ?? 1),
        ),
        side: !isActive
            ? MaterialStateProperty.all<BorderSide>(
                BorderSide(color: getTextColor),
              )
            : null,
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? Utils.extraLowRadius)),
        )),
        padding: MaterialStateProperty.all<EdgeInsets>(padding ?? EdgeInsets.all(Utils.normalPadding)),
      ),
    );
  }
}
