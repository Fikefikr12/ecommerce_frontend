import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:flutter/material.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) =>SizedBox(height: 14,) ,
      itemCount: 10,
      itemBuilder:(_,index)=> CircularContainer(
        showBorder: true,
        backgroundColor: Colors.white,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.monetization_on),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Processing',
                        style: TextStyle(color: AppColor.primary),
                      ),
                      Text('07 Nov 2024', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right)),
              ],
            ),
            SizedBox(height: 14,),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.tag),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order',
                              style: TextStyle(color: AppColor.primary,
                              fontSize: 12),
                            ),
                            Text(
                              '[#235f9]',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'shipping Date',
                              style: TextStyle(color: AppColor.primary,
                              fontSize: 12),
                            ),
                            Text(
                              '04 Nov 2124',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
