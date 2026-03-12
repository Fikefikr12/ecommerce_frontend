import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/rounded_images.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:ecommerce_frontend/features/shope/view/home/widget/curved_edge_widget.dart';
import 'package:flutter/material.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                  child: Image(
                    image: AssetImage(
                      "assets/images/onbording/es1.jpg",
                    ),
                  ),
                ),
              ),
            ),
    
            Positioned(
              left: 24,
              bottom: 20,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => SizedBox(width: 24),
                  itemCount: 6,
                  itemBuilder: (_, index) => RoundedImage(
                    imageUrl: "assets/images/onbording/es1.jpg",
                    width: 80,
                    height: 80,
                    backgroundColor: Colors.white,
                    border: Border.all(color: AppColor.primary),
                    padding: EdgeInsets.all(4),
                  ),
                ),
              ),
            ),
            CustomAppbar(
              backgroundColor: Colors.transparent,
               showBackArrow: true,
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.favorite,color: Colors.red,))],
          ),
          ],
        ),
      ),
    );
  }
}
