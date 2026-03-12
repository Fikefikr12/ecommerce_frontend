import 'package:flutter/material.dart';

class LoginFormDivider extends StatelessWidget {
  const LoginFormDivider({super.key, required this.dividerText});
  final String dividerText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Flexible(
            child: Divider(
              color: Colors.grey,
              thickness: 0.5,
              indent: 60,
              endIndent: 10,
            ),
          ),
          Text(dividerText),
          Flexible(
            child: Divider(
              color: Colors.grey,
              thickness: 0.5,
              indent: 10,
              endIndent: 60,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
