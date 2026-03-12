import 'package:ecommerce_frontend/features/onbording/bloc/onbording_bloc.dart';
import 'package:ecommerce_frontend/features/onbording/bloc/onbording_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NextOnbordingButton extends StatelessWidget {
  const NextOnbordingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return   Positioned(
      bottom: 70,
      right: 20,
      child: ElevatedButton(
        onPressed: (){
        context.read<OnbordingBloc>().add(NextPageEvent());
      },
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        backgroundColor: Colors.black,
        iconColor: Colors.white
      ),
        child: Icon(Icons.chevron_right),),
    );
  }
}