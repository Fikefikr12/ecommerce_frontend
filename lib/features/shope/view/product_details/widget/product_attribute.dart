import 'package:ecommerce_frontend/core/util/common/widgets/choise_chipe.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/product_title_text.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:ecommerce_frontend/features/shope/view/product_details/widget/product_price.dart';
import 'package:flutter/material.dart';

class ProductAttribute extends StatelessWidget {
  const ProductAttribute({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularContainer(
          radius: 16,
          padding: EdgeInsets.all(8),
          backgroundColor: Colors.grey,
          child: Column(
            children: [
              Row(
                children: [
                  SectionHeader(title: "Variation", ShowActionButton: false),
                  SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ProductTitleText(title: "Price :  "),
                          // actual price
                          Text(
                            '\$25',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 24),
                          // sale price
                          ProductPrice(price: "20"),
                        ],
                      ),
                      // stock
                      Row(
                        children: [
                          ProductTitleText(title: "stock:"),
                          SizedBox(width: 16),
                          Text('In stock'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              // Variation description
              ProductTitleText(
                title:
                    "This is the description of the product and it can go up to max 4 lines",
                maxLines: 4,
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: "Colors"),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                FChoiseChipe(
                  text: "Green",
                  selected: true,
                  onSelected: (value) {},
                ),
                FChoiseChipe(
                  text: "Blue",
                  selected: false,
                  onSelected: (value) {},
                ),
                FChoiseChipe(
                  text: "Yellow",
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            SectionHeader(title: "Size"),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                FChoiseChipe(
                  text: "Eu 34",
                  selected: true,
                  onSelected: (value) {},
                ),
                FChoiseChipe(
                  text: "Eu 36",
                  selected: false,
                  onSelected: (value) {},
                ),
                FChoiseChipe(
                  text: "Eu 38",
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
