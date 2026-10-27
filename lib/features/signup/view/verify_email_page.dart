import 'package:ecommerce_frontend/core/service/auth_service.dart';
import 'package:ecommerce_frontend/core/util/common/success/success_page.dart';
import 'package:ecommerce_frontend/features/login/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmailPage extends StatelessWidget {
    VerifyEmailPage({super.key});

  // 🔥 create AuthService instance
    final authService = AuthService();


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              icon: Icon(Icons.clear),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Image(
                image: AssetImage("assets/images/onbording/e3.jpg"),
                width: size * 0.6,
              ),

              SizedBox(height: 20),
              Text(
                "Verify your email address!",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
               // 🔥 Show current user email dynamically
              Text(
               FirebaseAuth.instance.currentUser?.email ?? "No email",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10),
              
              // Text(
              //   "Congradulation! Your Account Awaits: Verify your Email to start shopping and Experiance aworld of unrivaied  \n            Deals and Personalized offers.",
              //   style: TextStyle(color: Colors.black45, fontSize: 14),
              // ),
              // SizedBox(height: 20),
              // Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(5),
              //   ),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => SuccessPage(
              //             image: "assets/images/onbording/e3.jpg",
              //             title:
              //                 "Your account successfully \n             created!",
              //             subTitle:
              //                 "Welcome to your ultimate Shopping Destination: Your Account is Created, Unleash the joy of  \n            Seamless Online Shopping!",
              //             onPressed: () {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => LoginPage(),
              //                 ),
              //               );
              //             },
              //           ),
              //         ),
              //       );
              //     },
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.blueAccent,
              //       foregroundColor: Colors.white,
              //     ),
              //     child: Text("Continue"),
              //   ),
              // ),
              // SizedBox(height: 20),
              // Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(5),
              //   ),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => VerifyEmailPage(),
              //         ),
              //       );
              //     },
              //     style: TextButton.styleFrom(),
              //     child: Text("Resend Email"),
              //   ),
              // ),
               const Text(
                "Check your inbox and click the verification link.",
                style: TextStyle(color: Colors.black45),
              ),

              const SizedBox(height: 20),

              // ================= CONTINUE BUTTON =================
              ElevatedButton(
                onPressed: () async {
                  // 🔥 Check if email is verified
                  await authService.handleEmailVerification(context);
                },
                child: const Text("I have verified"),
              ),

              const SizedBox(height: 20),

              // ================= RESEND BUTTON =================
              ElevatedButton(
                onPressed: () async {
                  // 🔥 resend email
                  await authService.resendVerificationEmail(context);
                },
                child: const Text("Resend Email"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
