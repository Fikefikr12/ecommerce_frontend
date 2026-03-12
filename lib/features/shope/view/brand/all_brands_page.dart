import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:ecommerce_frontend/features/shope/view/all-products/sortable_product.dart';
import 'package:ecommerce_frontend/features/shope/view/brand/brand_products.dart';
import 'package:ecommerce_frontend/features/shope/view/home/widget/grid_layout.dart';
import 'package:ecommerce_frontend/features/shope/view/store/widget/brand_card.dart';
import 'package:flutter/material.dart';

class AllBrandsPage extends StatelessWidget {
  const AllBrandsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: CustomAppbar(showBackArrow: true,title: Text("Brand ",style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold
      ),)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SectionHeader(title: "Brands",ShowActionButton: false,),
              SizedBox(height: 16,),

              // brands
              GridLayout(
                itemCount: 10,mainAxisExtent: 80, itemBuilder: (context,index)=>BrandCard(showBorder: true,onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BrandProducts()));
                },),)
            ],
          ),
        ),
      ),
    );
  }
}