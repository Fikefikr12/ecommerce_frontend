import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:flutter/material.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({super.key, required this.selectedAddress});

  final bool selectedAddress;
  @override
  Widget build(BuildContext context) {
    return CircularContainer(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      showBorder: true,
      backgroundColor: selectedAddress
          ? AppColor.primary.withOpacity(0.5)
          : Colors.transparent,
      borderColor: selectedAddress ? Colors.transparent : Colors.grey.shade300,
      margin: EdgeInsets.only(bottom: 24),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: Icon(
              selectedAddress ? Icons.check_circle : null,
              color: selectedAddress ? Colors.black54 : null,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "John Doe",
                maxLines: 1,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text('+251 967 825 369', maxLines: 1),
              SizedBox(height: 4),
              Text(
                "82345 Timmy Coves,south Liana, Maine, 76659, USA",
                softWrap: true,
                
              ),
            ],
          ),
        ],
      ),
    );
  }
}
