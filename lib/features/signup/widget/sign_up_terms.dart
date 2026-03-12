import 'package:flutter/material.dart';

class SignUpTerms extends StatelessWidget {
  const SignUpTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: true, onChanged: (value) {}),
        SizedBox(width: 12),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'isAgreeTo ', style: TextStyle(fontSize: 12)),
              TextSpan(
                text: 'privacy Policy  ',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  color: Colors.blueAccent,
                ),
              ),
              TextSpan(text: 'and  ', style: TextStyle(fontSize: 12)),
              TextSpan(
                text: 'Terms of use ',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
