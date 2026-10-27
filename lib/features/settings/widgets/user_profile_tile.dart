import 'package:ecommerce_frontend/core/util/common/widgets/circular_image.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_bloc.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({super.key, required this.onPressed});

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopeBloc, ShopeState>(
      builder: (context, state) {
        return ListTile(
          leading: CircularImage(
            borderRadius: BorderRadius.circular(50),
            image: "assets/images/onbording/ep.jpg",
            height: 50,
            width: 50,
            padding: 0,
          ),
          title: Text(
            state.currentUser?.name ?? '',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            state.currentUser?.email ?? '',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          trailing: IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.edit),
            color: Colors.white,
          ),
        );
      },
    );
  }
}
