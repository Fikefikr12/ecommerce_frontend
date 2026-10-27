import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/product_card_horizontal.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/rounded_images.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:ecommerce_frontend/data/model/product_model.dart';
import 'package:flutter/material.dart';

class SubCatagoryPage extends StatelessWidget {
  final String title;
  final String image;
  final List<Product> products;
  const SubCatagoryPage({
    required this.title,
    required this.image,
    required this.products,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print("Image url: $image");
    return Scaffold(
      appBar: CustomAppbar(title: Text(title), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // banner
              RoundedImage(
                imageUrl: image,
                applyImageRadius: true,
                isNetworkImage: true,
              ),
              SizedBox(height: 32),

              // sub catagory
              Column(
                children: [
                  SectionHeader(title: 'Sport shoes'),
                  SizedBox(height: 36),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      itemCount: products.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => SizedBox(width: 16),
                      itemBuilder: (context, index) =>
                          ProductCardHorizontal(product: products[index]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
