import 'package:ecommerce_frontend/core/util/common/widgets/product_card_vertical.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:ecommerce_frontend/data/model/brand.dart';
import 'package:ecommerce_frontend/data/model/category.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_bloc.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_event.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_state.dart';
import 'package:ecommerce_frontend/features/shope/view/home/widget/grid_layout.dart';
import 'package:ecommerce_frontend/features/shope/view/store/widget/brand_show_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatagoryTab extends StatefulWidget {
  final CategoryModel category;
  final List<BrandModel> brands;
  const CatagoryTab({required this.category, required this.brands, super.key});

  @override
  State<CatagoryTab> createState() => _CatagoryTabState();
}

class _CatagoryTabState extends State<CatagoryTab> {
  @override
  void initState() {
    super.initState();
    context.read<ShopeBloc>().add(GetAllProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopeBloc, ShopeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            shrinkWrap: true,
            //  physics: NeverScrollableScrollPhysics(),
            children: [
              ...widget.brands.map((brand) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: BrandShowCase(
                    brand: brand,
                    images: [
                      "assets/images/onbording/esh2.jpg",
                      "assets/images/onbording/eb.jpg",
                      "assets/images/onbording/esh2.jpg",
                    ],
                  ),
                );
              }),

              // brand
              SizedBox(height: 10),

              // product
              SectionHeader(title: "you might like it ,", onPressed: () {}),
              SizedBox(height: 14),
              GridLayout(
                itemCount: state.products.length,
                itemBuilder: (_, index) {
                  final product = state.products[index];
                  return ProductCardVertical(product: product);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
