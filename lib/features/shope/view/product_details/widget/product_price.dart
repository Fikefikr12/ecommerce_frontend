import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    super.key,
    this.currencySign = '\$',
    required this.price,
    this.maxLines = 1,
    this.lineThrough = false,
  });

  final String currencySign, price;
  final int maxLines;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      currencySign + price,
      maxLines: maxLines,
      style: TextStyle(
        decoration: lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
        fontSize: 18,
      ),
    );
  }
}