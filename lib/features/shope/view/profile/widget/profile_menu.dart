import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key, 
    required this.onPressed, 
      this.icon=Icons.chevron_right, 
    required this.title, 
    required this.value,
  });
final VoidCallback onPressed;
final IconData icon;
final String title,value;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(flex: 3, child: Text(title,style: TextStyle(color: Colors.black54),)),
              Expanded(flex: 5, child: Text(value,style: TextStyle(color: Colors.black),)),
              Expanded(child: Icon(icon))
          ],
        ),
      ),
    );
  }
}