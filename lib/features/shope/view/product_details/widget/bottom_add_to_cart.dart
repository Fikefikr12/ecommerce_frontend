import 'package:ecommerce_frontend/core/service/toast_service.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_icon.dart';
import 'package:ecommerce_frontend/data/model/product_model.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_bloc.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_event.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class BottomAddToCart extends StatefulWidget {
  final Product product;
  final String? selectedSize;
  final String? selectedColor;
  final String? selectedImage;
  final bool enabled;

  const BottomAddToCart({
    super.key,
    required this.product,
    this.selectedColor,
    this.selectedSize,
    this.selectedImage,
    this.enabled = true,
  });

  @override
  State<BottomAddToCart> createState() => _BottomAddToCartState();
}

class _BottomAddToCartState extends State<BottomAddToCart> {
  int quantity = 1;

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void addToCart() {
    context.read<ShopeBloc>().add(
      AddToCartEvent(
        productItem: widget.product.id,
        quantity: quantity,
        selectedColor: widget.selectedColor,
        selectedSize: widget.selectedSize,
        selectedImage: widget.selectedImage,
      ),
    );
    ToastService.showSuccessToast(
      context: context,
      message: 'Product added to cart♥️👌',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CirculatIcon(
                  icon: Icons.remove,
                  width: 40,
                  height: 40,
                  backgroundColor: Colors.black,
                  iconColor: Colors.white,
                  onPressed: decreaseQuantity,
                ),
                SizedBox(width: 24),
                Text(quantity.toString()),
                SizedBox(width: 24),
                CirculatIcon(
                  icon: Icons.add,
                  width: 40,
                  height: 40,
                  backgroundColor: Colors.black,
                  iconColor: Colors.white,
                  onPressed: increaseQuantity,
                ),
              ],
            ),
            BlocBuilder<ShopeBloc, ShopeState>(
              builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: state.isLoading ? null : addToCart,
                  child: state.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text("Add to Cart"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
