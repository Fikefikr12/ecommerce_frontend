import 'package:ecommerce_frontend/core/util/common/widgets/brand_title_with_verification.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_image.dart';
import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,   this.showBorder=true, this.onTap,
  });
final bool showBorder;
final void Function()? onTap;
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
                isNetworkImage: false,
                image: 'assets/images/onbording/esh2.jpg',
                backgroundColor: Colors.transparent,
                // overlayColor: Colors.
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  BrandTitleWithVerification(
                    title: "Nike",
                    iconColor: Colors.blue,
                    brandTextSizes: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  Text(
                    '245 products are mfjjf',
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
