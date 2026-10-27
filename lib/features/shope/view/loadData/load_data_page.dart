import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:ecommerce_frontend/features/settings/widgets/setting_menu_tile.dart';
import 'package:flutter/material.dart';

class LoadDataPage extends StatefulWidget {
  const LoadDataPage({super.key});

  @override
  State<LoadDataPage> createState() => _LoadDataPageState();
}

class _LoadDataPageState extends State<LoadDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(showBackArrow: true, title: Text('Upload Data')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SectionHeader(title: "Main Record", ShowActionButton: false),
              SizedBox(height: 24),
              SettingMenuTile(
                title: 'Upload Categories',
                subtitle: '',
                icon: Icons.app_blocking_outlined,
                trailing: Icon(Icons.arrow_circle_up_rounded),
              ),
              SettingMenuTile(
                title: 'Upload Brand',
                subtitle: '',
                icon: Icons.book,
                trailing: Icon(Icons.arrow_circle_up_rounded),
              ),
              SettingMenuTile(
                title: 'Upload Products',
                subtitle: '',
                icon: Icons.shop_outlined,
                trailing: Icon(Icons.arrow_circle_up_rounded),
              ),
              SettingMenuTile(
                title: 'Upload Banners',
                subtitle: '',
                icon: Icons.image,
                trailing: Icon(Icons.arrow_circle_up_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
