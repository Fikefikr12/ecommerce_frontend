import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/favorite_icon.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/rounded_images.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:ecommerce_frontend/data/model/product_model.dart';
import 'package:ecommerce_frontend/features/shope/view/home/widget/curved_edge_widget.dart';
import 'package:ecommerce_frontend/features/shope/view/product_details/widget/full_screen_image.dart';
import 'package:flutter/material.dart';

// CHANGED: StatefulWidget -> StatelessWidget
// WHY: the selected image is now owned by the parent, so the page can send it
// to the cart and change it when the variation changes.
class ProductImageSlider extends StatelessWidget {
  final Product product; // still needed for FavoriteIcon
  final List<String> images; // CHANGED: gallery list from parent
  final String? selectedImage; // CHANGED: replaces selectedColor + index
  final ValueChanged<String> onImageChanged; // CHANGED: now required

  const ProductImageSlider({
    super.key,
    required this.product,
    required this.images,
    required this.selectedImage,
    required this.onImageChanged,
  });

  @override
  Widget build(BuildContext context) {
    // CHANGED: network check by URL, with a safe fallback
    final main = selectedImage ?? (images.isNotEmpty ? images.first : '');
    final hasImage = main.isNotEmpty;

    return CurvedEdgeWidget(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: RoundedImage(
                    imageUrl: hasImage
                        ? main
                        : "assets/images/onbording/es1.jpg",
                    isNetworkImage: hasImage,
                    applyImageRadius: true,
                    width: double.infinity,
                    height: 350,
                    fit: BoxFit.contain,
                    // CHANGED: no RangeError when there are no images
                    onPressed: !hasImage
                        ? null
                        : () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FullScreenImage(
                                imageUrl: main,
                                isNetworkImage: true,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ),

            // CHANGED: only show thumbnails if there is more than one image
            if (images.length > 1)
              Positioned(
                left: 24,
                right: 24,
                bottom: 20,
                child: SizedBox(
                  height: 80,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemCount: images.length,
                    itemBuilder: (_, index) {
                      final image = images[index];
                      return GestureDetector(
                        // CHANGED: report the tap to the parent, no local setState
                        onTap: () => onImageChanged(image),
                        child: RoundedImage(
                          imageUrl: image,
                          isNetworkImage: true,
                          width: 80,
                          height: 80,
                          backgroundColor: Colors.white,
                          border: Border.all(
                            color: image == main
                                ? AppColor.primary
                                : Colors.grey.shade300,
                          ),
                          padding: const EdgeInsets.all(4),
                        ),
                      );
                    },
                  ),
                ),
              ),

            CustomAppbar(
              backgroundColor: Colors.transparent,
              showBackArrow: true,
              actions: [FavoriteIcon(product: product)],
            ),
          ],
        ),
      ),
    );
  }
}
