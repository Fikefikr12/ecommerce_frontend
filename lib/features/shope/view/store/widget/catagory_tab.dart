import 'package:ecommerce_frontend/core/util/common/widgets/product_card_vertical.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:ecommerce_frontend/features/shope/view/home/widget/grid_layout.dart';
import 'package:ecommerce_frontend/features/shope/view/store/widget/brand_show_case.dart';
import 'package:flutter/material.dart';

class CatagoryTab extends StatelessWidget {
  const CatagoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding: const EdgeInsets.all(24.0),
      child: ListView(
        shrinkWrap: true,
      //  physics: NeverScrollableScrollPhysics(),
       children:[ 
        // brand
        BrandShowCase(images: [
        "assets/images/onbording/esh2.jpg",
        "assets/images/onbording/eb.jpg",
      "assets/images/onbording/esh2.jpg",
       ],),
         SizedBox(height: 10),
            BrandShowCase(images: [
        "assets/images/onbording/esh2.jpg",
        "assets/images/onbording/eb.jpg",
      "assets/images/onbording/esh2.jpg",
       ],),
       SizedBox(height: 10),
       // product
      
       SectionHeader(title: "you might like it ,",onPressed: (){},),
       SizedBox(height: 14,),
       GridLayout(itemCount: 4, itemBuilder: (_,index)=> ProductCardVertical()),
        
       
       ]
         ),
    );
  }
}