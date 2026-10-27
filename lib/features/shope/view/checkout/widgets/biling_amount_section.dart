import 'package:flutter/material.dart';

class BilingAmountSection extends StatelessWidget {
  const BilingAmountSection({
    super.key,
    required this.subtotal,
    required this.shippingFee,
  });

  final double subtotal;
  final double shippingFee;

  Widget _row(String label, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(
            value.toStringAsFixed(2),
            style: TextStyle(
              fontSize: bold ? 16 : 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _row('Subtotal', subtotal),
        _row('Shipping Fee', shippingFee),
        // REMOVED: Tax row. The order has no tax field, so it would show a number never charged.
        _row('Order total', subtotal + shippingFee, bold: true),
        // Tax Fee
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text("Tax Fee", style: TextStyle(fontWeight: FontWeight.w500)),
        //     Text("\$6.0", style: TextStyle(fontWeight: FontWeight.w700)),
        //   ],
        // ),

        SizedBox(height: 8),
      ],
    );
  }
}
