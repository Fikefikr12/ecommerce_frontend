import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FRatingBarIndicator extends StatelessWidget {
  const FRatingBarIndicator({
    super.key, required this.rating,
  });
  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemBuilder: (_,__)=>Icon(Icons.star,color: AppColor.primary,),
      rating: rating,
      itemSize: 20,
      unratedColor: Colors.grey,);
  }
}
