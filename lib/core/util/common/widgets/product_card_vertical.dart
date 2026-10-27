import 'package:ecommerce_frontend/core/service/toast_service.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/brand_title_with_verification.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_icon.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/favorite_icon.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/product_price_text.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/product_title_text.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/rounded_images.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/shadows.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:ecommerce_frontend/data/model/product_model.dart';
import 'package:ecommerce_frontend/features/shope/view/product_details/product_details_page.dart';
import 'package:flutter/material.dart';

class ProductCardVertical extends StatelessWidget {
  final Product product;
  const ProductCardVertical({required this.product, super.key});

  void _openDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsPage(product: product),
      ),
    );
    ToastService.showSuccessToast(
      context: context,
      message: 'See product details',
    );
  }

  @override
  Widget build(BuildContext context) {
    final image = product.cardImage;
    return GestureDetector(
      onTap: () => _openDetails(context),
      child: Container(
        width: 180,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircularContainer(
              height: 180,
              //   width: 180,
              padding: EdgeInsets.all(8),
              backgroundColor: Colors.white,
              child: Stack(
                children: [
                  Center(
                    child: RoundedImage(
                      imageUrl: image.isNotEmpty
                          ? image
                          : "assets/images/onbording/esh2.jpg",
                      applyImageRadius: true,
                      isNetworkImage: image.isNotEmpty,
                    ),
                  ),
                  if (product.discountPercent > 0)
                    Positioned(
                      top: 2,
                      child: CircularContainer(
                        height: 22,
                        width: 40,
                        radius: 8,
                        backgroundColor: AppColor.secondary.withOpacity(0.8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        child: Text(
                          '-${product.discountPercent}%',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: FavoriteIcon(product: product),
                  ),

                  if (!product.inStock)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Out of stock',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductTitleText(title: product.title),
                  SizedBox(height: 10),
                  if (product.brand.isNotEmpty)
                    BrandTitleWithVerification(
                      title: product.brand,
                      iconColor: Colors.blueAccent,
                    ),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        if (product.hasSale) ...[
                          Text(
                            '\$${product.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Flexible(
                          child: ProductPriceText(
                            price: product.displayPrice.toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () => _openDetails(context),
                  child: Container(
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
