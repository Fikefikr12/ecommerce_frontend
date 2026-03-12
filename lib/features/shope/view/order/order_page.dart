import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/features/shope/view/order/widgets/order_list_item.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: CustomAppbar(title: Text('My Orders'),showBackArrow: true,),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: OrderListItem(),
      ),
    );
  }
}