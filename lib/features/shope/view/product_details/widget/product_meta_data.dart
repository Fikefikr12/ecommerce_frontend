import 'package:ecommerce_frontend/core/util/common/widgets/brand_title_with_verification.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_image.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/product_title_text.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:ecommerce_frontend/data/model/product_model.dart';
import 'package:ecommerce_frontend/features/shope/view/product_details/widget/product_price.dart';
import 'package:flutter/material.dart';

class ProductMetaData extends StatelessWidget {
  final Product product;
  final double price;
  final double salePrice;
  final int stock;
  const ProductMetaData({
    super.key,
    required this.product,
    required this.price,
    required this.salePrice,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    final pct = discountPercentOf(price, salePrice);
    final onSale = pct > 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (onSale) ...[
              CircularContainer(
                height: 22,
                width: 40,
                radius: 8,
                backgroundColor: AppColor.secondary.withOpacity(0.8),
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Text(
                  '-$pct%',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ),
              SizedBox(width: 24),
              // price
              Text(
                '\$250',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],

            SizedBox(width: 24),
            ProductPrice(price: '${product.price}'),
          ],
        ),
        SizedBox(height: 18),
        // title
        ProductTitleText(title: product.title),
        SizedBox(height: 18),
        // stock
        Row(
          children: [
            ProductTitleText(title: "status"),
            SizedBox(width: 24),
            Text('In Stock', style: TextStyle(fontWeight: FontWeight.w800)),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            CircularImage(
              height: 32,
              width: 32,
              image: "assets/images/onbording/en.jpg",
            ),
            BrandTitleWithVerification(
              title: product.brand,
              iconColor: Colors.blueAccent,
            ),
          ],
        ),
      ],
    );
  }
}
