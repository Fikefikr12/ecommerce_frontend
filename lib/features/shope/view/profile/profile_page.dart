import 'package:ecommerce_frontend/core/util/common/widgets/circular_image.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:ecommerce_frontend/features/login/views/login_page.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_bloc.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_event.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_state.dart';
import 'package:ecommerce_frontend/features/shope/view/profile/widget/change_name.dart';
import 'package:ecommerce_frontend/features/shope/view/profile/widget/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopeBloc, ShopeState>(
      builder: (context, state) {
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
                        CircularImage(
                          image:
                              state.currentUser?.profileImage != null &&
                                  state.currentUser!.profileImage!.isNotEmpty
                              ? state.currentUser!.profileImage!.first
                              : "assets/images/onbording/ep.jpg",
                          isNetworkImage:
                              state.currentUser?.profileImage != null &&
                              state.currentUser!.profileImage!.isNotEmpty,
                        ),

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
                  ProfileMenu(
                    title: 'Name',
                    value: state.currentUser?.name ?? '',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ChangeName();
                          },
                        ),
                      );
                    },
                  ),
                  ProfileMenu(
                    title: 'User Name',
                    value: state.currentUser?.username ?? '',
                    onPressed: () {},
                  ),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  /// Heading Personal Info
                  const SectionHeader(
                    title: 'Personal Information',
                    ShowActionButton: false,
                  ),
                  const SizedBox(height: 16),

                  ProfileMenu(
                    title: 'User ID',
                    value: state.currentUser?.id ?? '',
                    onPressed: () {},
                    icon: Icons.copy,
                  ),
                  ProfileMenu(
                    title: 'E-mail',
                    value: state.currentUser?.email ?? '',
                    onPressed: () {},
                  ),
                  ProfileMenu(
                    title: 'Phone Number',
                    value: state.currentUser?.phone ?? '',
                    onPressed: () {},
                  ),
                  ProfileMenu(title: 'Gender', value: 'Male', onPressed: () {}),
                  ProfileMenu(
                    title: 'Date of Birth',
                    value: '10 Oct, 1994',
                    onPressed: () {},
                  ),
                  Divider(),
                  SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        final currentUser = context
                            .read<ShopeBloc>()
                            .state
                            .currentUser;

                        if (currentUser == null) return;

                        context.read<ShopeBloc>().add(
                          DeleteUserEvent(id: currentUser.id!),
                        );

                        await FirebaseAuth.instance.signOut();

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => LoginPage()),
                        );
                      },
                      child: Text(
                        'Delete Account',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
