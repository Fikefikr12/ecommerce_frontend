import 'package:ecommerce_frontend/features/signup/view/verify_email_page.dart';
import 'package:ecommerce_frontend/features/signup/widget/sign_up_terms.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "First Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "last Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20),
          TextFormField(
            expands: false,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.class_),
              labelText: "Username",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            expands: false,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: "email",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            expands: false,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone),
              labelText: "Phone Number",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            expands: false,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.password),
              suffixIcon: Icon(Icons.remove_red_eye),
              labelText: "Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          SignUpTerms(),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyEmailPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
              child: Text("Create Account"),
            ),
          ),
        ],
      ),
    );
  }
}
