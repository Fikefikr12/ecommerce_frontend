import 'package:ecommerce_frontend/core/service/auth_service.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_bloc.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_event.dart';
import 'package:ecommerce_frontend/features/shope/widgets/bottom_navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialButtons extends StatelessWidget {
  SocialButtons({super.key});

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () async {
              // 1, call google sign in
              final userCredential = await authService.signInWithGoogle();

              // 2,check success
              if (userCredential != null) {
                context.read<ShopeBloc>().add(GetCurrentUserEvent());

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => BottomNavigationMenu()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Google sign -in failed")),
                );
              }
            },
            icon: Image(height: 50, image: AssetImage("assets/logos/eg.jpg")),
          ),
        ),
        SizedBox(width: 30),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: Image(height: 50, image: AssetImage("assets/logos/ef.png")),
          ),
        ),
      ],
    );
  }
}
