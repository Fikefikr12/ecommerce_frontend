import 'package:flutter/material.dart';

class CirculatIcon extends StatelessWidget {
  const CirculatIcon({
    super.key,
    this.width,
    this.height,
    this.size=24,
    required this.icon,
    this.iconColor,
    this.backgroundColor,
    this.onPressed,
  });
  final double? width, height, size;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor,
      ),
      child: IconButton(onPressed: onPressed, icon: Icon(icon,color: iconColor),iconSize: size,),
    );
  }
}
