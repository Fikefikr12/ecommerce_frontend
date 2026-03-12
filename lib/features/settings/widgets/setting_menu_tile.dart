import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:flutter/material.dart';

class SettingMenuTile extends StatelessWidget {
  const SettingMenuTile({super.key, 
  required this.title,
   required this.subtitle, 
   required this.icon,
    this.trailing,  
     this.onTap
    });
 final String title ,subtitle;
 final IconData icon;
 final Widget? trailing;
 final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return   ListTile(
      leading: Icon(icon,size: 28,color: AppColor.primary,),
      title: Text(title,style: TextStyle(
        color: Colors.black
      ),),
         subtitle: Text(subtitle,style: TextStyle(
        color: Colors.black
      ),),
      trailing: trailing,
      onTap: onTap,
    );
  }
}