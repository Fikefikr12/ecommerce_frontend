import 'package:ecommerce_frontend/core/util/common/widgets/brand_title_with_verification.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/product_title_text.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/rounded_images.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:ecommerce_frontend/data/model/cart_Item.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final CartItemModel item;
  const CartItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final product = item.productItem;
    final img = item.displayImage;
    final hasImage = img.isNotEmpty;

    const labelStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w300);
    const valueStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);

    return Row(
      children: [
        RoundedImage(
          width: 60,
          height: 60,
          imageUrl: hasImage ? img : "assets/images/onbording/es1.jpg",
          isNetworkImage: hasImage,
          padding: EdgeInsets.all(8),
          backgroundColor: Colors.white,
        ),
        SizedBox(width: 24),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BrandTitleWithVerification(
                title: product.brand,
                iconColor: AppColor.buttonPrimary,
              ),
              ProductTitleText(title: product.title, maxLines: 1),

              // color / size come from the product detail page
              if (item.selectedColor != null || item.selectedSize != null)
                Text.rich(
                  TextSpan(
                    children: [
                      if (item.selectedColor != null) ...[
                        const TextSpan(text: 'Color  ', style: labelStyle),
                        TextSpan(
                          text: '${item.selectedColor}',
                          style: valueStyle,
                        ),
                      ],
                      if (item.selectedSize != null) ...[],
                      if (item.selectedSize != null) ...[
                        const TextSpan(text: 'Size  ', style: labelStyle),
                        TextSpan(text: item.selectedSize, style: valueStyle),
                      ],
                    ],
                  ),
                ),
              Text(
                '\$${item.unitPrice.toStringAsFixed(2)} each',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
