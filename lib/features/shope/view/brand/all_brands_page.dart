import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_bloc.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_event.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_state.dart';
import 'package:ecommerce_frontend/features/shope/view/all-products/sortable_product.dart';
import 'package:ecommerce_frontend/features/shope/view/brand/brand_products.dart';
import 'package:ecommerce_frontend/features/shope/view/home/widget/grid_layout.dart';
import 'package:ecommerce_frontend/features/shope/view/store/widget/brand_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllBrandsPage extends StatefulWidget {
  const AllBrandsPage({super.key});

  @override
  State<AllBrandsPage> createState() => _AllBrandsPageState();
}

class _AllBrandsPageState extends State<AllBrandsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ShopeBloc>().add(GetAllBrandsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopeBloc, ShopeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppbar(
            showBackArrow: true,
            title: Text(
              "Brand ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SectionHeader(title: "Brands", ShowActionButton: false),
                  SizedBox(height: 16),

                  // brands
                  GridLayout(
                    itemCount: state.brands.length,
                    mainAxisExtent: 80,
                    itemBuilder: (context, index) {
                      final brand = state.brands[index];
                      return BrandCard(
                        brand: brand,
                        showBorder: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BrandProducts(
                                brand: brand,
                                title: brand.name,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
