import 'package:ecommerce_frontend/core/service/toast_service.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_icon.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:ecommerce_frontend/data/model/cart_Item.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_bloc.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductQuantityWithAddAndRemove extends StatelessWidget {
  final CartItemModel item;
  const ProductQuantityWithAddAndRemove({required this.item, super.key});

  Future<void> _showRemoveConfirmation(BuildContext context) async {
    final shouldRemove = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Remove Product'),
          content: const Text(
            'Are you sure you want to remove this product from your cart?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
                ToastService.showSuccessToast(
                  context: context,
                  message: 'Item removed from cart ',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    if (shouldRemove == true && context.mounted) {
      context.read<ShopeBloc>().add(RemoveCartItemEvent(itemId: item.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final max = item.availableStock;
    final atMax = max != null && item.quantity >= max;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CirculatIcon(
          width: 32,
          height: 32,
          backgroundColor: Colors.grey.shade300,
          icon: Icons.remove,
          iconColor: Colors.black,
          size: 16,
          onPressed: () {
            if (item.quantity > 1) {
              context.read<ShopeBloc>().add(
                UpdateCartQuantityEvent(
                  itemId: item.id,
                  quantity: item.quantity - 1,
                ),
              );
            } else {
              _showRemoveConfirmation(context);
            }
          },
        ),
        SizedBox(width: 12),
        Text(item.quantity.toString()),
        SizedBox(width: 12),
        CirculatIcon(
          width: 32,
          height: 32,
          backgroundColor: atMax ? Colors.grey.shade300 : AppColor.primary,
          icon: Icons.add,
          iconColor: Colors.white,
          size: 16,
          onPressed: atMax
              ? () {}
              : () {
                  context.read<ShopeBloc>().add(
                    UpdateCartQuantityEvent(
                      itemId: item.id,
                      quantity: item.quantity + 1,
                    ),
                  );
                },
        ),
      ],
    );
  }
}
