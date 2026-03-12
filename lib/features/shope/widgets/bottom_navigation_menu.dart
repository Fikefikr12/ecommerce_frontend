import 'package:ecommerce_frontend/features/settings/settings_page.dart';
import 'package:ecommerce_frontend/features/shope/view/home/home_page.dart';
import 'package:ecommerce_frontend/features/shope/view/wishlist/wish_list_page.dart';
import 'package:ecommerce_frontend/features/shope/view/store/store_page.dart';
import 'package:flutter/material.dart';

class BottomNavigationMenu extends StatefulWidget {
  const BottomNavigationMenu({super.key});

  @override
  State<BottomNavigationMenu> createState() => _BottomNavigationMenuState();
}

class _BottomNavigationMenuState extends State<BottomNavigationMenu> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    StorePage(),
    WishListPage(),
    SettingsPage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.blueAccent,
        height: 80,
        selectedIndex: _selectedIndex,
        onDestinationSelected: onItemTapped,
        elevation: 0,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.shop), label: "store"),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: "Wishlist",
          ),
          NavigationDestination(icon: Icon(Icons.person), label: "profile"),
        ],
      ),
    );
  }
}
