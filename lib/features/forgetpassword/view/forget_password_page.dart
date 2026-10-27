import 'package:ecommerce_frontend/core/service/auth_service.dart';
import 'package:ecommerce_frontend/features/forgetpassword/view/reset_password_page.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatelessWidget {
    ForgetPasswordPage({super.key});

  final AuthService authService =AuthService();

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
                "Forget Password",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),
              Text(
                "Don't worry sometimes people can forget too , enter your email and we will send you a password reset link.",
                style: TextStyle(
                  fontSize: 16,
                  //  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: authService.email,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "enter your email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ResetPasswordPage(),
                    //   ),
                    // );
                    authService.forgetpassword(context, authService.email.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
