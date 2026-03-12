import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  const CircularImage(
     {
    super.key,
      this.width=56,
      this.height=56,
      this.padding=8,
    this.backgroundColor,
    this.overlayColor,
    this.isNetworkImage=false,
    required this.image,
    this.borderRadius = const BorderRadius.all(Radius.circular(14)),
    this.fit,
  });

  final double width, height, padding;
  final Color? backgroundColor;
  final Color? overlayColor;
  final bool isNetworkImage;
  final String image;
  final BoxFit? fit;
  final BorderRadius borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child:  ClipRRect(
        borderRadius: borderRadius,
        child: Image(image: 
        isNetworkImage?NetworkImage(image):
        AssetImage(image) as ImageProvider,
        color: overlayColor,
        fit: fit,),
      ),
    );
  }
}
