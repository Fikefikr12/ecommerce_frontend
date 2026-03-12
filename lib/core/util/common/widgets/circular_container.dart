import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    this.width ,
    this.height ,
    this.padding,
    this.child,
    this.backgroundColor = Colors.white,
    this.margin,
    this.radius = 16,
    this.showBorder = false, 
      this.borderColor=AppColor.borderPrimary,
  });
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final Widget? child;
  final Color backgroundColor;
  final EdgeInsets? margin;
  final double radius;
  final bool showBorder;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: showBorder ? Border.all(color: borderColor) : null,
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
