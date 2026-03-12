import 'package:ecommerce_frontend/features/onbording/bloc/onbording_bloc.dart';
import 'package:ecommerce_frontend/features/onbording/bloc/onbording_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkipOnbording extends StatelessWidget {
  const SkipOnbording({super.key});

  @override
  Widget build(BuildContext context) {
    return  Positioned(
      top: 40,right: 30,
      child: TextButton(onPressed: (){
        context.read<OnbordingBloc>().add(SkipEvent());
      }, 
      child: Text("Skip",
      style: TextStyle(
        color: Colors.white
      ),)),);
  }
}