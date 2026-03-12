import 'package:ecommerce_frontend/core/util/common/widgets/circular_image.dart';
import 'package:flutter/material.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key, required this.onPressed,
  });

 final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircularImage(
        borderRadius: BorderRadius.circular(50),
        image: "assets/images/onbording/ep.jpg",
        height: 50,
        width: 50,
        padding: 0,
      ),
      title: Text(
        "Code With Fikade",
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        "fikadetibebe@gmail.com",
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: Icon(Icons.edit),
        color: Colors.white,
      ),
      
    );
  }
}
