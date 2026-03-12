import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/product_price_text.dart';
import 'package:ecommerce_frontend/features/shope/view/cart/widgets/cart_item.dart';
import 'package:ecommerce_frontend/features/shope/view/cart/widgets/product_quantity_with_add_and_remove.dart';
import 'package:ecommerce_frontend/features/shope/view/cart/widgets/reusable_cart_items.dart';
import 'package:ecommerce_frontend/features/shope/view/checkout/checkout_page.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        showBackArrow: true,
        title: Text(
          'Cart',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ReusableCartItems(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return CheckoutPage();
            }));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text("Checkout \$256.0"),
        ),
      ),
    );
  }
}
