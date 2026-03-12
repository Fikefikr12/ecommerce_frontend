import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/features/shope/widgets/cart_counter_icon.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      backgroundColor: Colors.transparent,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Good day for shopping ",
          style: TextStyle(
         fontSize: 12,color: Colors.white
          ),),
          SizedBox(height: 5,),
          Text("Taimoor Sikander ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14
            ,color: Colors.white
          ),)
        ],
      ),
      actions: [
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 10),
         child: CartCounterIcon(onPressed: () {},iconColor: Colors.white,),
       )
      ],
    );
  }
}