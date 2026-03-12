import 'package:ecommerce_frontend/features/onbording/bloc/onbording_bloc.dart';
import 'package:ecommerce_frontend/features/onbording/bloc/onbording_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DotOnbording extends StatelessWidget {
  const DotOnbording({super.key,required this.controller});
 final PageController controller;
  @override
  Widget build(BuildContext context) {
    return   Positioned(
      bottom: 90,
      left: 30,
      child: SmoothPageIndicator(
        controller: controller, 
        count: 3,
        onDotClicked: (index){
          context.read<OnbordingBloc>().add(PageChangedEvent(index));
        },
        effect: ExpandingDotsEffect(
          activeDotColor: Colors.deepPurple,
          dotHeight: 6
        ),
         ));
  }
}