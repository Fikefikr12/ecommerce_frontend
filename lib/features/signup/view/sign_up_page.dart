import 'package:ecommerce_frontend/features/login/widget/login_form_divider.dart';
import 'package:ecommerce_frontend/features/login/widget/social_buttons.dart';
import 'package:ecommerce_frontend/features/signup/widget/sign_up_form.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let's Create Account",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              SignUpForm(),
              SizedBox(height: 15),
              LoginFormDivider(dividerText: "Or Sign Up with"),
              SizedBox(height: 15),
              SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}


