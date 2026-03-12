import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/product_card_horizontal.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/rounded_images.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:flutter/material.dart';

class SubCatagoryPage extends StatelessWidget {
  const SubCatagoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: Text('Sport'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // banner
              RoundedImage(
                imageUrl: "assets/images/onbording/ebra.jpg",
                applyImageRadius: true,
              ),
              SizedBox(height: 32),

              // sub catagory
              Column(
                children: [
                  SectionHeader(title: 'Sport shoes'),
                  SizedBox(height: 36),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder:(context,index)=> SizedBox(width: 16,),
                      itemBuilder:(context,index)=> ProductCardHorizontal()
                      ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
