import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:ecommerce_frontend/features/shope/view/home/widget/curved_edge_widget.dart';
import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      child: Container(
        color: AppColor.primary,
        padding: EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              right: -250,
              top: -150,
              child: CircularContainer(
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: CircularContainer(
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
