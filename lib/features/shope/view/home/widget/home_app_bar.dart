import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_bloc.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_state.dart';
import 'package:ecommerce_frontend/features/shope/widgets/cart_counter_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopeBloc, ShopeState>(
      builder: (context, state) {
        final cartCount = state.cart?.totalItems ?? 0;

        return CustomAppbar(
          backgroundColor: Colors.transparent,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good day for shopping ",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
              SizedBox(height: 5),
              Text(
                state.currentUser?.name ?? 'Guest',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 10,
              ),
              child: CartCounterIcon(
                count: cartCount,
                onPressed: () {},
                iconColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
