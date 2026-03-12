import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:ecommerce_frontend/features/shope/view/productReview/product_review_page.dart';
import 'package:ecommerce_frontend/features/shope/view/product_details/widget/bottom_add_to_cart.dart';
import 'package:ecommerce_frontend/features/shope/view/product_details/widget/product_attribute.dart';
import 'package:ecommerce_frontend/features/shope/view/product_details/widget/product_image_slider.dart';
import 'package:ecommerce_frontend/features/shope/view/product_details/widget/product_meta_data.dart';
import 'package:ecommerce_frontend/features/shope/view/product_details/widget/ratingand_share.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductImageSlider(),
            Padding(
              padding: const EdgeInsets.only(right: 24.0, left: 24, bottom: 24),
              child: Column(
                children: [
                  RatingandShare(),
                  ProductMetaData(),
                  // attributes
                  ProductAttribute(),
                  SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text("Checkout"),
                    ),
                  ),
                  SizedBox(height: 24),
                  SectionHeader(title: "Description", ShowActionButton: false),
                  SizedBox(height: 24),
                  ReadMoreText(
                    "For an e-commerce checkout page, product descriptions must be concise, reassuring, and scannable to prevent last-minute cart abandonment. They should reinforce the decision to buy, highlighting key benefits over features.",
                    trimMode: TrimMode.Line,
                    trimLines: 2,
                    trimCollapsedText: 'show more',
                    trimExpandedText: 'Less',
                    moreStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                    lessStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 24),
                  Divider(),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SectionHeader(
                        title: "Reviews(199)",
                        onPressed: () {},
                        ShowActionButton: false,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductReviewPage()));
                        },
                        icon: Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
