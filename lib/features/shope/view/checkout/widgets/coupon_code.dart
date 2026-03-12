import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:flutter/material.dart';

class CouponCode extends StatelessWidget {
  const CouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularContainer(
      showBorder: true,
      backgroundColor: Colors.white,
      padding: EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 16),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Have a Promo code? Enter here',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
                // enabledBorder: OutlineInputBorder(
                //   borderSide: BorderSide(
                //     color: AppColor.borderPrimary
                //   )
                // )
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: 90,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade300,
                foregroundColor: Colors.black.withOpacity(0.5),
                side: BorderSide(
                  color: Colors.grey.shade300
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Apply"),
            ),
          ),
        ],
      ),
    );
  }
}
