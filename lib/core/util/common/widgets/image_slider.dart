import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/rounded_images.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key, required this.banners});

 final List<String> banners;
  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentIndex = 0;

  // final List<String> images = [
  //   'assets/images/onbording/esh2.jpg',
  //   'assets/images/onbording/eb.jpg',
  //   'assets/images/onbording/e3.jpg',
  // ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, _) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: widget.banners.map((image) {
            return RoundedImage(imageUrl: image, height: 170, width: 300);
          }).toList(),
        ),
        SizedBox(height: 20),

        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i<widget.banners.length; i++)
                CircularContainer(
                  backgroundColor: _currentIndex ==i?AppColor.primary:Colors.grey,
                  height: 4,
                  width: _currentIndex == i?30:20,
                  margin: EdgeInsets.only(right: 10),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
