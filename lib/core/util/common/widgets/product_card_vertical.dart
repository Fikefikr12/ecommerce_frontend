import 'package:ecommerce_frontend/core/util/common/widgets/brand_title_with_verification.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_icon.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/product_price_text.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/product_title_text.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/rounded_images.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/shadows.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:ecommerce_frontend/features/shope/view/product_details/product_details_page.dart';
import 'package:flutter/material.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {   
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsPage()));
      },
      child: Container(
        width: 180,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          children: [
            CircularContainer(
              height: 180,
              padding: EdgeInsets.all(8),
              backgroundColor: Colors.white,
              child: Stack(
                children: [
                  RoundedImage(
                    imageUrl: "assets/images/onbording/esh2.jpg",
                    applyImageRadius: true,
                  ),
                  Positioned(
                    top: 2,
                    child: CircularContainer(
                      height: 22,
                      width: 40,
                      radius: 8,
                      backgroundColor: AppColor.secondary.withOpacity(0.8),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      child: Text(
                        "25%",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CirculatIcon(
                      icon: Icons.favorite,
                      backgroundColor: Colors.white,
                      iconColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [ProductTitleText(title: "Black Nike Air Shoes",),
                SizedBox(height: 10,),
                BrandTitleWithVerification(title: "Nike",),
             ]),
            ),
              Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ProductPriceText(price: '35',),
                    ),
                     
                     Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(16)
                        )
                      ),
                      child: SizedBox(
                        height: 36,
                        width: 36,
                        child: Center(child: Icon(Icons.add,color: Colors.white,))),
                     )
                  ],
                )
          ],
        ),
      ),
    );
  }
}





