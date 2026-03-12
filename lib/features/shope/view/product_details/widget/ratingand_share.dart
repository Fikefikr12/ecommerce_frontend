import 'package:flutter/material.dart';

class RatingandShare extends StatelessWidget {
  const RatingandShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      // Rating
      Row(
        children: [
          Icon(Icons.star,color: Colors.amber,size: 24,),
          SizedBox(width: 8,),
          Text.rich(
            TextSpan(children: [
              TextSpan(text: "5.0",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
              TextSpan(text: "(199)")
            ])
            )         
        ],
      ),
      IconButton(onPressed: (){}, icon: Icon(Icons.share))
    ],);
  }
}

