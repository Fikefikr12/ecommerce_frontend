import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:flutter/material.dart';

class BilingAddressSection extends StatelessWidget {
  const BilingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "Shipping Address",
          buttonTitle: "change",
          onPressed: () {},
        ),
         Text(
              "fikade app ",
              style: TextStyle( fontWeight: FontWeight.w500),
            ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.phone,color: Colors.grey,size: 16,),
              SizedBox(width: 8),
            Text(
              "+251 967 825 369 ",
              style: TextStyle( fontWeight: FontWeight.w500),
            ),
          ],
        ),
         SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.history,color: Colors.grey,size: 16,),
              SizedBox(width: 8),
            Text(
              "South Liana , Maine 86748 ,USA ",
              style: TextStyle( fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
