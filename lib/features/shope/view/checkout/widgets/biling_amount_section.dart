import 'package:flutter/material.dart';

class BilingAmountSection extends StatelessWidget {
  const BilingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // sub total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Subtotal",style: TextStyle(
              fontWeight: FontWeight.w500
            ),),
            Text("\$256.0",style: TextStyle(
              fontWeight: FontWeight.w700
            ),),
          ],
        ),
        SizedBox(height: 8,),
        // shipping fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Shipping Fee",style: TextStyle(
              fontWeight: FontWeight.w500
            ),),
            Text("\$6.0",style: TextStyle(
              fontWeight: FontWeight.w700
            ),),
          ],
        ),
        SizedBox(height: 8,),
        // Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tax Fee",style: TextStyle(
              fontWeight: FontWeight.w500
            ),),
            Text("\$6.0",style: TextStyle(
              fontWeight: FontWeight.w700
            ),),
          ],
        ),
        SizedBox(height: 8,),
        // order total 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Order total",style: TextStyle(
              fontWeight: FontWeight.w500
            ),),
            Text("\$256.0",style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700
            ),),
          ],
        ),
        SizedBox(height: 8,),
      ],
    );
  }
}