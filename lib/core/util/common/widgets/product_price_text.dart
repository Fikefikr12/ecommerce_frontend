import 'package:flutter/material.dart';

class ProductPriceText extends StatelessWidget {
  const ProductPriceText({
    super.key, required this.price,   this.currencySign='\$',   this.maxLines=1,
  });
final String price ,currencySign;
final  int maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(currencySign+price,
    maxLines: maxLines,
    style: TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.bold
    ),);
  }
}