import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:flutter/material.dart';

class AddNewAddress extends StatelessWidget {
  const AddNewAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppbar(
        showBackArrow: true,
        title: Text("Add new Address"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Name',
                     enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.borderPrimary
                          )
                         )
                  ),
                ),
                SizedBox(height: 16,),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Phone Number',
                     enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.borderPrimary
                          )
                         )
                  ),
                ),
                SizedBox(height: 16,),
                Row(
                  children: [
                    Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.directions),
                      labelText: 'Street',
                          enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.borderPrimary
                          )
                         )
                    ),
                  ),
                ), 
                
                SizedBox(width: 16,),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.post_add),
                      labelText: 'Postal Code',
                          enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.borderPrimary
                          )
                         )
                    ),
                  ),
                ),
                ],),
                 SizedBox(height: 16,),
                 Row(
                  children: [
                    Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.build),
                      labelText: 'city',
                          enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.borderPrimary
                          )
                         )
                    ),
                  ),
                ), 
                
                SizedBox(width: 16,),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.local_activity),
                      labelText: 'State',
                         enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.borderPrimary
                          )
                         )
                    ),
                  ),
                ),
                ],),
                SizedBox(height: 16,),
                 TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.join_full),
                      labelText: 'Country',
                       enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.borderPrimary
                          )
                         )
                    ),
                  ),
                  SizedBox(height: 24,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      )
                    ), child: Text('Save'),),
                  )
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}