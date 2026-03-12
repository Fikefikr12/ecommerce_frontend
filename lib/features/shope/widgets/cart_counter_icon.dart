import 'package:ecommerce_frontend/features/shope/view/cart/cart_page.dart';
import 'package:flutter/material.dart';

class CartCounterIcon extends StatelessWidget {
  const CartCounterIcon({
    super.key,
     required this.iconColor, 
    required this.onPressed,
  });
final Color iconColor;
final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Stack(
     children: [
        IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> CartPage()));
        }, icon: Icon(Icons.shopping_bag_outlined),color: iconColor,),
        Positioned(
         right: 0,
         
         child: Container(
           width: 18,
           height: 18,
           decoration: BoxDecoration(
             color: Colors.black,
             borderRadius: BorderRadius.circular(100)
           ),
           child: Center(
             child: Text("2",style: TextStyle(
               color: Colors.white,
               fontSize: 12
             ),),
           ),
         ))
     ],
    );
  }
}