import 'package:ecommerce_frontend/core/util/common/widgets/product_price_text.dart';
import 'package:ecommerce_frontend/features/shope/view/cart/widgets/cart_item.dart';
import 'package:ecommerce_frontend/features/shope/view/cart/widgets/product_quantity_with_add_and_remove.dart';
import 'package:flutter/material.dart';

class ReusableCartItems extends StatelessWidget {
  const ReusableCartItems({
    super.key,  
     this.showAddRemoveButtons=true,
  });

final bool showAddRemoveButtons;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 2,
      separatorBuilder: (_, __) => SizedBox(height: 32),
      itemBuilder: (_, index) => Column(
        children: [
        CartItem(),
        if(showAddRemoveButtons)
          SizedBox(height: 16),
          if(showAddRemoveButtons)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 70),
                  ProductQuantityWithAddAndRemove(),
                ],
              ),
              ProductPriceText(price: '256'),
            ],
          ),
        ],
      ),
    );
  }
}