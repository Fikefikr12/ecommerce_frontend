import 'package:flutter/material.dart';

class ProductTitleText extends StatelessWidget {
  const ProductTitleText({
    super.key,
    required this.title,
      this.maxLines=1,
    this.textAlign,
      this.size=13,
  });

  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: size,fontWeight: FontWeight.w500),
    );
  }
}