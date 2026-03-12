import 'package:ecommerce_frontend/features/login/views/login_page.dart';
import 'package:ecommerce_frontend/features/onbording/bloc/onbording_bloc.dart';
import 'package:ecommerce_frontend/features/onbording/bloc/onbording_event.dart';
import 'package:ecommerce_frontend/features/onbording/bloc/onbording_state.dart';
import 'package:ecommerce_frontend/features/onbording/widgets/dot_onbording.dart';
import 'package:ecommerce_frontend/features/onbording/widgets/next_onbording_button.dart';
import 'package:ecommerce_frontend/features/onbording/widgets/reusable_onbording.dart';
import 'package:ecommerce_frontend/features/onbording/widgets/skip_onbording.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnbordingPage extends StatefulWidget {
  const OnbordingPage({super.key});

  @override
  State<OnbordingPage> createState() => _OnbordingPageState();
}

class _OnbordingPageState extends State<OnbordingPage> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<OnbordingBloc, OnboardingState>(
        listener: (context, state) {
          // animate page
          pageController.animateToPage(
            state.currentIndex,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
          // Navigate when completed
      if(state.isCompleted) {
        Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginPage()));
      }
         },
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              onPageChanged: (index) {
                context
                    .read<OnbordingBloc>()
                    .add(PageChangedEvent(index));
              },
              children: const [
                ReusableOnbording(
                  image: "assets/images/onbording/e2.jpg",
                  title: "Choose your Product",
                  subtitle:
                      "Welcome to a world of limitless choices - your perfect product awaits!",
                ),
                ReusableOnbording(
                  image: "assets/images/onbording/e3.jpg",
                  title: "Select Payment Method",
                  subtitle:
                      "For seamless transactions, choose your payment path!",
                ),
                ReusableOnbording(
                  image: "assets/images/onbording/e1.jpg",
                  title: "Deliver at Your Door Step",
                  subtitle:
                      "From our doorstep to yours - Swift & secure delivery!",
                ),
              ],
            ),
    
            /// Skip
            const SkipOnbording(),
    
            /// Dot
            DotOnbording(controller: pageController),
    
            /// Next
            const NextOnbordingButton(),
          ],
        ),
      ),
    );
  }
}