import 'package:ecommerce_frontend/features/login/widget/login_form.dart';
import 'package:ecommerce_frontend/features/login/widget/login_form_divider.dart';
import 'package:ecommerce_frontend/features/login/widget/login_header.dart';
import 'package:ecommerce_frontend/features/login/widget/social_buttons.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 20),
          child: Column(
            children: [
              LoginHeader(),
              LoginForm(),
              LoginFormDivider(dividerText: "Or Sign in With"),
              SizedBox(height: 20),
              SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
