import 'package:ecommerce_frontend/core/util/common/widgets/brand_title_with_verification.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_image.dart';
import 'package:ecommerce_frontend/data/model/brand.dart';
import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,
    this.showBorder = true,
    this.onTap,
    required this.brand,
  });
  final bool showBorder;
  final void Function()? onTap;
  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircularContainer(
        radius: 16,
        padding: EdgeInsets.all(4),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: CircularImage(
                isNetworkImage: brand.image.isNotEmpty,
                image: brand.image.isNotEmpty
                    ? brand.image
                    : 'assets/images/onbording/esh2.jpg',
                backgroundColor: Colors.transparent,
                // overlayColor: Colors.
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BrandTitleWithVerification(
                    title: brand.name,
                    iconColor: Colors.blue,
                    brandTextSizes: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  Text(
                    '${brand.productsCount} Products',
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
