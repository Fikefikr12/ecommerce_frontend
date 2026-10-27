import 'package:ecommerce_frontend/core/service/auth_service.dart';
import 'package:ecommerce_frontend/core/util/validators/validation.dart';
import 'package:ecommerce_frontend/features/forgetpassword/view/forget_password_page.dart';
import 'package:ecommerce_frontend/features/shope/widgets/bottom_navigation_menu.dart';
import 'package:ecommerce_frontend/features/signup/view/sign_up_page.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final AuthService authService = AuthService();

  bool isObsecured = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      //key: authService.s,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: authService.email,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: "enter your email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: MyValidator.validateEmail,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: authService.password,
              obscureText: isObsecured,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password_rounded),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObsecured = !isObsecured;
                    });
                  },
                  icon: Icon(
                    isObsecured ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                labelText: "enter your password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: MyValidator.validateEmail,
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    Text("Remember Me"),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgetPasswordPage(),
                      ),
                    );
                  },
                  child: Text("Forget PassWord"),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigationMenu()));
                  await authService.signIn(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Sign in"),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: Text("Create Account"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
