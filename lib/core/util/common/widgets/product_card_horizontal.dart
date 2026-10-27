import 'package:ecommerce_frontend/core/util/common/widgets/brand_title_with_verification.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_icon.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/favorite_icon.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/product_title_text.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/rounded_images.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/shadows.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:ecommerce_frontend/data/model/product_model.dart';
import 'package:ecommerce_frontend/features/shope/view/product_details/widget/product_price.dart';
import 'package:flutter/material.dart';

class ProductCardHorizontal extends StatelessWidget {
  final Product product;
  const ProductCardHorizontal({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade300,
      ),
      child: Row(
        children: [
          // thubnail
          CircularContainer(
            height: 120,
            padding: EdgeInsets.all(8),
            backgroundColor: AppColor.light,
            child: Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: RoundedImage(
                    imageUrl: product.imageUrl.isNotEmpty
                        ? product.imageUrl.first
                        : "assets/images/onbording/esh2.jpg",
                    applyImageRadius: true,
                    isNetworkImage: true,
                  ),
                ),
                Positioned(
                  top: 0,
                  child: CircularContainer(
                    height: 22,
                    width: 40,
                    radius: 8,
                    backgroundColor: AppColor.secondary.withOpacity(0.8),
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      "${product.salePrice}%",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: -10,
                  child: FavoriteIcon(product: product),
                ),
              ],
            ),
          ),
          // Details
          SizedBox(
            width: 172,
            child: Padding(
              padding: EdgeInsets.only(top: 8, left: 8),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductTitleText(title: product.title, maxLines: 2),
                      SizedBox(height: 8),
                      BrandTitleWithVerification(
                        title: product.brand!,
                        iconColor: Colors.blueAccent,
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: ProductPrice(price: product.price.toString()),
                      ),
                      // add to cart button
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: SizedBox(
                          height: 36,
                          width: 36,
                          child: Center(
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
