import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:flutter/material.dart';

class BilingPaymentSection extends StatelessWidget {
  const BilingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: "Payment method",
          buttonTitle: "change",
          onPressed: () {},
        ),
        SizedBox(height: 8),
        Row(
          children: [
            CircularContainer(
              width: 60,
              height: 60,
              backgroundColor: Colors.white,
              padding: EdgeInsets.all(8),
              child: Image(
                image: AssetImage("assets/images/onbording/epa.png"),
                fit: BoxFit.contain,
              ),
            ),
              SizedBox(width: 8),
            Text(
              "Paypal ",
              style: TextStyle( fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
