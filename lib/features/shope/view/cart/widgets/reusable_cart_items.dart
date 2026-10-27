import 'package:ecommerce_frontend/core/util/common/widgets/product_price_text.dart';
import 'package:ecommerce_frontend/data/model/cart.dart';
import 'package:ecommerce_frontend/data/model/cart_Item.dart';
import 'package:ecommerce_frontend/features/shope/view/cart/widgets/cart_item.dart';
import 'package:ecommerce_frontend/features/shope/view/cart/widgets/product_quantity_with_add_and_remove.dart';
import 'package:flutter/material.dart';

class ReusableCartItems extends StatelessWidget {
  const ReusableCartItems({
    super.key,
    required this.items,
    this.showAddRemoveButtons = true,
    this.scrollable = true,
  });

  final List<CartItemModel> items;
  final bool showAddRemoveButtons;
  final bool scrollable;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: 32),
      itemBuilder: (_, index) {
        final item = items[index];

        return Column(
          key: ValueKey(item.id), // keeps rows stable when one is removed
          children: [
            CartItem(item: item),
            SizedBox(height: 16),
            if (showAddRemoveButtons) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 70),
                      ProductQuantityWithAddAndRemove(item: item),
                    ],
                  ),
                  ProductPriceText(price: item.lineTotal.toStringAsFixed(2)),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
