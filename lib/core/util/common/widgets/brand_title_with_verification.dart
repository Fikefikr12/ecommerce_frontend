import 'package:ecommerce_frontend/core/util/common/widgets/brand_title_text.dart';
import 'package:flutter/material.dart';

class BrandTitleWithVerification extends StatelessWidget {
  const BrandTitleWithVerification({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor,
    this.textAlign,
    this.brandTextSizes = 12,
      this.fontWeight=FontWeight.normal
  });
  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final double brandTextSizes;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        BrandTitleText(
          title: title,
          maxLines: maxLines,
          brandTextSizes: brandTextSizes,
          textColor: textColor,
          fontWeight: fontWeight,
        ),
        SizedBox(width: 10),
        Icon(Icons.verified, color: iconColor, size: 12),
      ],
    );
  }
}
