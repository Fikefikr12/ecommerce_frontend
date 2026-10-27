import 'package:ecommerce_frontend/core/service/auth_service.dart';
import 'package:ecommerce_frontend/core/util/validators/validation.dart';
import 'package:ecommerce_frontend/features/signup/view/verify_email_page.dart';
import 'package:ecommerce_frontend/features/signup/widget/sign_up_terms.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final AuthService authService = AuthService();
  // create instance
  bool isObsecured = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: authService.signupFormKey, // connect form key
      child: Column(
        children: [
          TextFormField(
            controller: authService.name,
            expands: false,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              labelText: "Full Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            validator: MyValidator.validateName,
          ),

          SizedBox(height: 20),
          TextFormField(
            controller: authService.username,
            expands: false,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.class_),
              labelText: "Username",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: MyValidator.validateUsername,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: authService.email,
            expands: false,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: "email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: MyValidator.validateEmail,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: authService.phoneNumber,
            expands: false,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone),
              labelText: "Phone Number",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: MyValidator.validatePhoneNumber,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: authService.password,
            obscureText: isObsecured,
            expands: false,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.password),
              suffixIcon: IconButton(
                icon: Icon(
                  isObsecured ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  // toggle state
                  setState(() {
                    isObsecured = !isObsecured;
                  });
                },
              ),
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: MyValidator.validatePassword,
          ),
          SizedBox(height: 20),
          SignUpTerms(),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: ElevatedButton(
              onPressed: () async {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyEmailPage()));
                await authService.signUp(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Create Account"),
            ),
          ),
        ],
      ),
    );
  }
}
