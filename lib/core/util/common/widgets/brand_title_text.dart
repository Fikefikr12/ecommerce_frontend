import 'package:flutter/material.dart';

class BrandTitleText extends StatelessWidget {
  const BrandTitleText({
    super.key,
    required this.title,
      this.maxLines=1,
    required this.brandTextSizes,
    required this.textColor,
     this.textAlign=TextAlign.center,
     this.fontWeight=FontWeight.normal
  });

  final String title;
  final int maxLines;
  final double brandTextSizes;
  final Color? textColor;
  final TextAlign? textAlign;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: brandTextSizes,
       color:textColor,
       fontWeight: fontWeight
       ),
    );
  }
}