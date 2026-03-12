
import 'package:ecommerce_frontend/core/util/common/widgets/circular_icon.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:flutter/material.dart';

class ProductQuantityWithAddAndRemove extends StatelessWidget {
  const ProductQuantityWithAddAndRemove({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            ),
            SizedBox(width: 12),
            Text("2"),
            SizedBox(width: 12),
            CirculatIcon(
              width: 32,
              height: 32,
              backgroundColor: AppColor.primary,
              icon: Icons.add,
              iconColor: Colors.white,
              size: 16,
            ),
          ],
        )
      ;
  }
}