import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/features/shope/view/productReview/widget/overall_prduct_rating.dart';
import 'package:ecommerce_frontend/features/shope/view/productReview/widget/rating_bar_indicator.dart';
import 'package:ecommerce_frontend/features/shope/view/productReview/widget/user_review_card.dart';
import 'package:flutter/material.dart';

class ProductReviewPage extends StatelessWidget {
  const ProductReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        showBackArrow: true,
        title: Text("Review and Rating")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reviews and Ratings are verified and are from people who use the same type of use app",
                  ),
                  SizedBox(height: 12),
                  // over all Product rating
                  OverallProductRating(),
                  FRatingBarIndicator(rating: 3.5),
                  Text("12,611"),
                  SizedBox(height: 32),
                  UserReviewCard(),
                  UserReviewCard(), 
                  UserReviewCard(),
                   UserReviewCard(),
                  // user
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
