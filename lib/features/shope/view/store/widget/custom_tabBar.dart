import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSize {
  const CustomTabBar({
    super.key, required this.tabs,
  });

final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      indicatorColor: AppColor.primary,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.blueGrey,
      tabs: tabs);
  }
  
  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100);
}
