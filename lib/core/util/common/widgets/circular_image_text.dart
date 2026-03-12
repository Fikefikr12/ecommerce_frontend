import 'package:flutter/material.dart';

class CircularImageText extends StatelessWidget {
  const CircularImageText({
    super.key, 
    required this.image,
     required this.title,
        this.textColor=Colors.white, 
      this.backgroundColor=Colors.white, 
      this.onTap,
  });

 final String image ,title;
 final Color textColor;
 final Color? backgroundColor;
 final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(14),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(100),
              ),
             child: Image(image: AssetImage(image),fit: BoxFit.cover,),
            ),
            SizedBox(height: 3),
        
            SizedBox(
              width: 70,
              child: Center(
                child: Text(title,
                maxLines: 1,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: textColor,
                  fontSize: 10
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
