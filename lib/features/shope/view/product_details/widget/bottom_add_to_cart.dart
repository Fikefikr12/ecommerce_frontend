import 'package:ecommerce_frontend/core/util/common/widgets/circular_icon.dart';
import 'package:flutter/material.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white38,
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
                backgroundColor: Colors.grey,
                iconColor: Colors.white,
              ),
              SizedBox(width: 24),
              Text('2'),
              SizedBox(width: 24),
              CirculatIcon(
                icon: Icons.remove,
                width: 40,
                height: 40,
                backgroundColor: Colors.black,
                iconColor: Colors.white,
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              )
              
            ),
            onPressed: (){},
           child: Text("Add to Cart"))
        ],
      ),
    );
  }
}
