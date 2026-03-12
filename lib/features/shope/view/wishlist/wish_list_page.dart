import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/product_card_vertical.dart';
import 'package:ecommerce_frontend/features/shope/view/home/widget/grid_layout.dart';
import 'package:flutter/material.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppbar(
        backgroundColor: Colors.white,
        title: Text("WishList",style: TextStyle(
          fontWeight: FontWeight.bold,  
          fontSize: 16
        ),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(onPressed: (){}, icon: Icon(Icons.add)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              GridLayout(itemCount: 4, itemBuilder: (_,index)=>ProductCardVertical()),
            ],
          ),
        ),
      ),
    );
  }
}