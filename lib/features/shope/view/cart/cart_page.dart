import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_bloc.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_event.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_state.dart';
import 'package:ecommerce_frontend/features/shope/view/cart/widgets/reusable_cart_items.dart';
import 'package:ecommerce_frontend/features/shope/view/checkout/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isPlacingOrder = false;

  @override
  void initState() {
    super.initState();
    context.read<ShopeBloc>().add(GetCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        showBackArrow: true,
        title: const Text(
          'Cart',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocListener<ShopeBloc, ShopeState>(
        listenWhen: (p, c) =>
            c.errorMessage != null && p.errorMessage != c.errorMessage,
        listener: (context, state) {
          setState(() => _isPlacingOrder = false);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        },

        child: BlocBuilder<ShopeBloc, ShopeState>(
          buildWhen: (p, c) =>
              p.cart != c.cart ||
              p.isLoading != c.isLoading ||
              p.errorMessage != c.errorMessage,
          builder: (context, state) {
            final cart = state.cart;

            if (state.isLoading && cart == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (cart == null) {
              return Center(
                child: Text(
                  state.errorMessage ?? 'No cart data',
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }
            if (cart.items.isEmpty) {
              return const Center(
                child: Text(
                  'Your cart is empty',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: ReusableCartItems(items: cart.items),
            );
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<ShopeBloc, ShopeState>(
        buildWhen: (p, c) => p.isLoading != c.isLoading || p.cart != c.cart,
        builder: (context, state) {
          final items = state.cart?.items ?? [];
          final cartIsEmpty = items.isEmpty;

          // total computed from the same values the rows display
          final total = items.fold<double>(0, (sum, i) => sum + i.lineTotal);

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Subtotal',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '\$${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (cartIsEmpty || state.isLoading)
                        ? null
                        : () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CheckoutPage(),
                            ),
                          ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Checkout"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
