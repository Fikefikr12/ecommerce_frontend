import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage({
    super.key,
    required this.imageUrl,
    this.isNetworkImage = true,
  });

  final String imageUrl;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: InteractiveViewer(
            minScale: 1,
            maxScale: 5,
            child: isNetworkImage
                ? Image.network(imageUrl)
                : Image.asset(imageUrl),
          ),
        ),
      ),
    );
  }
}
