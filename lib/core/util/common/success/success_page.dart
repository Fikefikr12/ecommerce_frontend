import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key, required this.image, required this.title, required this.subTitle,required this.onPressed});
 final String image,title,subTitle;
 final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0,top: 60,right: 24),
          child: Column(
            children: [
               Image(image: AssetImage(image),
          width: size*0.6,),
          
          SizedBox(height: 20,),
          Text(title,style: TextStyle(
            color: Colors.black87,fontSize: 24,
            fontWeight: FontWeight.bold
          ),),
                 
           SizedBox(height: 10,),
          Text(subTitle,style: TextStyle(
            color: Colors.black45,fontSize: 14,
           
          ),),
          SizedBox(height: 20,),
           Container(
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                child: Text("Continue"),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}