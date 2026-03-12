import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 120,
          //width: 150,
          image: AssetImage("assets/logos/el.png"),
        ),
        Text(
          "Welcome Back, ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        Text(
          "Discover limitless  choises and unMatched Convenience",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
