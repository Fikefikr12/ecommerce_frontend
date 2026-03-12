import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:ecommerce_frontend/features/settings/widgets/setting_menu_tile.dart';
import 'package:ecommerce_frontend/features/settings/widgets/user_profile_tile.dart';
import 'package:ecommerce_frontend/features/shope/view/address/address_page.dart';
import 'package:ecommerce_frontend/features/shope/view/order/order_page.dart';
import 'package:ecommerce_frontend/features/shope/view/profile/profile_page.dart';
import 'package:ecommerce_frontend/features/shope/widgets/header_container.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderContainer(
              child: Column(
                children: [
                  CustomAppbar(
                    backgroundColor: AppColor.primary,
                    title: Text(
                      "Account",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),

                  UserProfileTile(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                    },
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SectionHeader(
                    title: "Account setting",
                    ShowActionButton: false,
                  ),
                  SizedBox(height: 16),
                  SettingMenuTile(
                    title: "My Addresses",
                    subtitle: "Set Shopping delivery Address",
                    icon: Icons.home,
                    onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressPage()));
                    },
                  ),
                  SettingMenuTile(
                    title: "My Cart",
                    subtitle: " Add ,remove products and move to checkout",
                    icon: Icons.shopping_cart,
                  ),
                  SettingMenuTile(
                    title: "My Orders",
                    subtitle: "In - progress and Completed Orders",
                    icon: Icons.shop,
                    onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderPage()));
                    },
                  ),
                  SettingMenuTile(
                    title: "Bank Account",
                    subtitle: "Withdraw balance to registered bank account",
                    icon: Icons.bakery_dining,
                  ),
                  SettingMenuTile(
                    title: "My Coupons",
                    subtitle: "List of all the discounted coupons",
                    icon: Icons.discord_sharp,
                  ),
                  SettingMenuTile(
                    title: "Notification",
                    subtitle: "Set any kind of notification message",
                    icon: Icons.notification_add,
                  ),
                  SettingMenuTile(
                    title: "Account Privacy",
                    subtitle: "Manage data usage and connected accounts",
                    icon: Icons.security,
                  ),
                  SizedBox(height: 32),

                  SectionHeader(title: "App settings", ShowActionButton: false),
                  SizedBox(height: 16),
                  SettingMenuTile(
                    title: "Load Data",
                    subtitle: "Upload Data your cloud Firebase",
                    icon: Icons.document_scanner,
                  ),
                  SettingMenuTile(
                    title: "Gelocation",
                    subtitle: " Set recommendation based on location",
                    icon: Icons.location_off,
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  SettingMenuTile(
                    title: "Safe Mode",
                    subtitle: " Search result is safe for all ages",
                    icon: Icons.security_update,
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  SettingMenuTile(
                    title: "HD Image Quality",
                    subtitle: "Set image quality to be seen",
                    icon: Icons.image,
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text("Logout"),
                    ),
                  ),

                  SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
