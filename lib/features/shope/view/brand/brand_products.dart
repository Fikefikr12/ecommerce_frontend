import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/features/shope/view/all-products/sortable_product.dart';
import 'package:ecommerce_frontend/features/shope/view/store/widget/brand_card.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(showBackArrow: true,
        title: Text("Nike",style: TextStyle(
        fontSize: 16,fontWeight: FontWeight.bold
      ),),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              BrandCard(),
              SizedBox(height: 16,),
              SortableProduct()
            ],
          ),
        ),
      ),
    );
  }
}