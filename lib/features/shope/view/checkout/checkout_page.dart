import 'package:ecommerce_frontend/core/util/common/success/success_page.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:ecommerce_frontend/features/shope/view/cart/widgets/reusable_cart_items.dart';
import 'package:ecommerce_frontend/features/shope/view/checkout/widgets/biling_address_section.dart';
import 'package:ecommerce_frontend/features/shope/view/checkout/widgets/biling_amount_section.dart';
import 'package:ecommerce_frontend/features/shope/view/checkout/widgets/biling_payment_section.dart';
import 'package:ecommerce_frontend/features/shope/view/checkout/widgets/coupon_code.dart';
import 'package:ecommerce_frontend/features/shope/widgets/bottom_navigation_menu.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(showBackArrow: true, title: Text("Order Review",style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600
      ),)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // item in cart
              ReusableCartItems(showAddRemoveButtons: false),
              SizedBox(height: 32),
              // coupon code
              CouponCode(),
              SizedBox(height: 32),
              // biling section
              CircularContainer(
                padding: EdgeInsets.all(16),
                showBorder: true,
                backgroundColor: Colors.white,
                child: Column(
                  children: [
                    // pricing
              BilingAmountSection(),
              SizedBox(height: 24,),

              Divider(),
               SizedBox(height: 24,),

                    // payment 
              BilingPaymentSection(),
                 SizedBox(height: 24,),
       
             BilingAddressSection()
                  // address 
                  ],
                ),
              )

            ],
          ),
        ),
      ),
       bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return SuccessPage(
                image: 'assets/images/onbording/en.jpg',
                title: "Payment Success!",
                subTitle: 'your it will be shipped soon!',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigationMenu()));
                } ,
              );
            }));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text("Checkout \$256.0"),
        ),
    )
    );
  }
}

