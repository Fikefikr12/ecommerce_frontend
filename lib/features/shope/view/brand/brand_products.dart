import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/data/model/brand.dart';
import 'package:ecommerce_frontend/features/shope/view/all-products/sortable_product.dart';
import 'package:ecommerce_frontend/features/shope/view/store/widget/brand_card.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  final BrandModel brand;
  final String title;
  const BrandProducts({super.key, required this.brand, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        showBackArrow: true,
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              BrandCard(brand: brand),
              const SizedBox(height: 16),
              SortableProduct(),
            ],
          ),
        ),
      ),
    );
  }
}
