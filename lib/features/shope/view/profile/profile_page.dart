import 'package:ecommerce_frontend/core/util/common/widgets/circular_image.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:ecommerce_frontend/features/shope/view/profile/widget/profile_menu.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: Text("Profile"), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    CircularImage(image: "assets/images/onbording/ep.jpg"),
                    TextButton(
                      onPressed: () {},
                      child: Text("Change Profile Picture"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Divider(),
              SizedBox(height: 16),
              SectionHeader(
                title: "Profile Information",
                ShowActionButton: false,
              ),
              SizedBox(height: 16),
              ProfileMenu(title: 'Name', value: 'Fikade Tibebe', onPressed: () {}),
              ProfileMenu(title: 'Username', value: 'fikadetibebe', onPressed: () {}),

const SizedBox(height: 16),
const Divider(),
const SizedBox(height:16),

/// Heading Personal Info
const SectionHeader(title: 'Personal Information', ShowActionButton: false,),
const SizedBox(height: 16),

ProfileMenu(title: 'User ID', value: '45689', onPressed: () {},icon: Icons.copy,),
ProfileMenu(title: 'E-mail', value: 'fikadetibebee@gmail.com', onPressed: () {}),
ProfileMenu(title: 'Phone Number', value: '+92-317-8059528', onPressed: () {}),
ProfileMenu(title: 'Gender', value: 'Male', onPressed: () {}),
ProfileMenu(title: 'Date of Birth', value: '10 Oct, 1994', onPressed: () {}),
Divider(),
SizedBox(height: 16,),
Center(child: TextButton(onPressed: (){}, child: Text('close Account',style: TextStyle(color: Colors.red),))),
SizedBox(height: 16,),
            ],
          ),
        ),
      ),
    );
  }
}


