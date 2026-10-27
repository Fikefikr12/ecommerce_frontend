import 'package:ecommerce_frontend/core/util/common/widgets/product_card_vertical.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_bloc.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_state.dart';
import 'package:ecommerce_frontend/features/shope/view/home/widget/grid_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SortableProduct extends StatelessWidget {
  const SortableProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopeBloc, ShopeState>(
      builder: (context, state) {
        // loading state
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        // empty state
        if (state.products.isEmpty) {
          return Text('No Products Found');
        }
        return Column(
          children: [
            DropdownButtonFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.sort_sharp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColor.borderPrimary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColor.borderPrimary),
                ),
              ),
              items:
                  [
                        'Name',
                        'Higher Price',
                        'Lower Price',
                        'Sale',
                        'Newest',
                        'Popularity',
                      ]
                      .map(
                        (option) => DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        ),
                      )
                      .toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 32),
            GridLayout(
              itemCount: state.products.length,
              itemBuilder: (_, index) {
                final product = state.products[index];
                return ProductCardVertical(product: product);
              },
            ),
          ],
        );
      },
    );
  }
}
