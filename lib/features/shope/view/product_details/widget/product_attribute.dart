import 'package:ecommerce_frontend/core/util/common/widgets/choise_chipe.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/product_title_text.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:ecommerce_frontend/data/model/product_model.dart';
import 'package:ecommerce_frontend/features/shope/view/product_details/widget/product_price.dart';
import 'package:flutter/material.dart';

// CHANGED: StatefulWidget -> StatelessWidget
// WHY: it kept its own selectedSize (an index) that the parent never saw,
// and a color index owned by the parent. Now both are VALUES owned by the parent.
class ProductAttributeWidget extends StatelessWidget {
  final Product product;
  final double price;
  final double salePrice;
  final int stock;
  final String? selectedColor; // CHANGED: int index -> String value
  final String? selectedSize; // CHANGED: new, comes from parent
  final ValueChanged<String> onColorSelected; // CHANGED: sends the value
  final ValueChanged<String> onSizeSelected; // CHANGED: new

  const ProductAttributeWidget({
    super.key,
    required this.product,
    required this.price,
    required this.salePrice,
    required this.stock,
    required this.selectedColor,
    required this.selectedSize,
    required this.onColorSelected,
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    // CHANGED: uses the model helper, no local getters
    final colors = product.valuesOf('color');
    final sizes = product.valuesOf('size');
    final onSale = discountPercentOf(price, salePrice) > 0;

    return Column(
      children: [
        // CHANGED: only show the variation box if the product has variations
        if (product.productVariations.isNotEmpty)
          CircularContainer(
            radius: 16,
            padding: const EdgeInsets.all(8),
            backgroundColor: Colors.grey.shade300,
            child: Column(
              children: [
                Row(
                  children: [
                    SectionHeader(title: "Variation", ShowActionButton: false),
                    const SizedBox(width: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ProductTitleText(title: "Price :  "),
                            // CHANGED: strikethrough only when on sale, uses
                            // the selected variation's price
                            if (onSale) ...[
                              Text(
                                '\$ ${price.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 24),
                            ],
                            ProductPrice(
                              price: (onSale ? salePrice : price)
                                  .toStringAsFixed(0),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            ProductTitleText(title: "stock:"),
                            const SizedBox(width: 16),
                            // CHANGED: uses the variation's stock, not product.stock (0 in your data)
                            Text(stock > 0 ? "In Stock" : "Out of Stock"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                // CHANGED: real description instead of the placeholder text
                if ((product.description).isNotEmpty)
                  ProductTitleText(title: product.description, maxLines: 4),
              ],
            ),
          ),
        const SizedBox(height: 24),

        // CHANGED: hide the section when the product has no colors
        if (colors.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(title: "Colors", ShowActionButton: false),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: colors.map((c) {
                  return FChoiseChipe(
                    text: c,
                    // CHANGED: compare VALUES, not indexes
                    selected: selectedColor == c,
                    onSelected: (_) => onColorSelected(c),
                  );
                }).toList(),
              ),
            ],
          ),
        const SizedBox(height: 16),

        if (sizes.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(title: "Size", ShowActionButton: false),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: sizes.map((s) {
                  return FChoiseChipe(
                    text: s,
                    selected: selectedSize == s,
                    // CHANGED: tell the parent (before, it stayed in local state)
                    onSelected: (_) => onSizeSelected(s),
                  );
                }).toList(),
              ),
            ],
          ),
      ],
    );
  }
}
