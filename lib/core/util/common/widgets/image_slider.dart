import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/rounded_images.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:ecommerce_frontend/data/model/banner.dart';
import 'package:ecommerce_frontend/features/settings/settings_page.dart';
import 'package:ecommerce_frontend/features/shope/view/cart/cart_page.dart';
import 'package:ecommerce_frontend/features/shope/view/checkout/checkout_page.dart';
import 'package:ecommerce_frontend/features/shope/view/wishlist/wish_list_page.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key, required this.banners});

  final List<BannerModel> banners;
  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentIndex = 0;

  void _navigateToScreen(BuildContext context, String? targetScreen) {
    switch (targetScreen) {
      case 'cart':
        Navigator.push(context, MaterialPageRoute(builder: (_) => CartPage()));

        break;

      case 'checkout':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CheckoutPage()),
        );
        break;

      case 'favorites':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => WishListPage()),
        );

        break;

      // case 'search':

      //  Navigator.push(context, MaterialPageRoute(builder: (_) => CartPage()));

      //   break;

      case 'settings':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SettingsPage()),
        );
        break;

      // case 'userAddress':

      //   // Navigator.push(... AddressPage());

      //   break;

      default:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Page not found')));
    }
  }

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
          items: widget.banners.map((banner) {
            return RoundedImage(
              imageUrl: banner.imageUrl,
              height: 170,
              width: 300,
              isNetworkImage: true,
              onPressed: () {
                _navigateToScreen(context, banner.targetScreen);
              },
            );
          }).toList(),
        ),
        SizedBox(height: 20),

        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < widget.banners.length; i++)
                CircularContainer(
                  backgroundColor: _currentIndex == i
                      ? AppColor.primary
                      : Colors.grey,
                  height: 4,
                  width: _currentIndex == i ? 30 : 20,
                  margin: EdgeInsets.only(right: 10),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
