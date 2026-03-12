import 'package:flutter/material.dart';

class ReusableOnbording extends StatelessWidget {
  const ReusableOnbording({
    super.key ,
   required this.image ,
   required this.title,
   required this.subtitle
   });


 final String image ,title ,subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image(
            image: AssetImage(image)),
            Text(title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700
            ),),
            SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(subtitle
                           , style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300
                            ),),
              ),
         
        ],
      ),
    );
  }
}
