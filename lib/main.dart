import 'package:ecommerce_frontend/features/login/bloc/login_bloc.dart';
import 'package:ecommerce_frontend/features/onbording/bloc/onbording_bloc.dart';
import 'package:ecommerce_frontend/features/splash/view/splass_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnbordingBloc>(
          create: (_) => OnbordingBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const SplashScreen(), // 👈 First screen
      ),
    );
  }
}