import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/features/shope/view/store/widget/brand_card.dart';
import 'package:flutter/material.dart';

class BrandShowCase extends StatelessWidget {
  const BrandShowCase({
    super.key, 
  required this.images
  });
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
          BrandCard(showBorder: false),
          SizedBox(height: 13,),
          Row(
            children: images
                .map((image) => brandTopProducrImageWidget(image, context))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget brandTopProducrImageWidget(String image, context) {
    return Expanded(
      child: CircularContainer(
        height: 100,
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.only(right: 4),
        backgroundColor: Colors.white10,
        child: Image(image: AssetImage(image), fit: BoxFit.contain),
      ),
    );
  }
}
