import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:ecommerce_frontend/features/shope/view/address/Widgets/add_new_address.dart';
import 'package:ecommerce_frontend/features/shope/view/address/Widgets/single_address.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewAddress()));
      },
      backgroundColor: AppColor.primary,
      child: Icon(Icons.add,color: Colors.white,),),
      appBar: CustomAppbar(
        showBackArrow: true,
        title: Text('Addresses',style: TextStyle(
          color: Colors.black
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SingleAddress(selectedAddress: true),
              SingleAddress(selectedAddress: false)
            ],
          ),
        ),
      ),
    );
  }
}