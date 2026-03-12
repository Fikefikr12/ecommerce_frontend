import 'package:ecommerce_frontend/core/util/common/widgets/brand_title_with_verification.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/product_title_text.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/rounded_images.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      RoundedImage(
        width: 60,
        height: 60,
        imageUrl: "assets/images/onbording/es1.jpg",
        padding: EdgeInsets.all(8),
        backgroundColor: Colors.white,
        ),
        SizedBox(width: 24,),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BrandTitleWithVerification(title: "Nike",iconColor: AppColor.buttonPrimary,),
              ProductTitleText(title: "Blue Sports Shoes ",maxLines: 1,),
              // attribuite
    
           Text.rich(
            TextSpan(children: [
              TextSpan(text: 'Color  ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w100)),
               TextSpan(text: 'Green  ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                TextSpan(text: 'Size  '  ,style: TextStyle( fontSize: 14,fontWeight: FontWeight.w100)),
                 TextSpan(text: 'UK 08  ',style: TextStyle( fontSize: 14,fontWeight: FontWeight.w500))
            ])
           )
        
            ],
          ),
        )
    ],);
  }
}