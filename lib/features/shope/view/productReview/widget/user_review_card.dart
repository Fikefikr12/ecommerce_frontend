import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:ecommerce_frontend/features/shope/view/productReview/widget/rating_bar_indicator.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/onbording/ep.jpg"),
                ),
                SizedBox(width: 24),
                Text(
                  "Fikade Tibebe",
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        ),
        Row(
          children: [
            FRatingBarIndicator(rating: 4.0),
            SizedBox(width: 24),
            Text("26,Nov,1993"),
          ],
        ),
        SizedBox(height: 24),
        ReadMoreText(
          "For an e-commerce checkout page, product descriptions must be concise, reassuring, and scannable to prevent last-minute cart abandonment. They should reinforce ...",
          trimMode: TrimMode.Line,
          trimLines: 1,
          trimCollapsedText: 'show more',
          trimExpandedText: 'Less',
          moreStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          lessStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 24),

        CircularContainer(
          radius: 8,
          backgroundColor: Colors.grey.shade300,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "F' store",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "02 Dec, 1994",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                ReadMoreText(
                  "For an e-commerce checkout page, product descriptions must be concise, reassuring, and scannable to prevent last-minute cart abandonment. They should reinforce ...",
                  trimMode: TrimMode.Line,
                  trimLines: 2,
                  trimCollapsedText: 'show more',
                  trimExpandedText: 'Less',
                  moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColor.primary,
                  ),
                  lessStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColor.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 32,)
      ],
    );
  }
}
