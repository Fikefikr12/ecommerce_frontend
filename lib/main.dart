import 'package:ecommerce_frontend/core/service/product_service.dart';
import 'package:ecommerce_frontend/core/service/user_service.dart';
import 'package:ecommerce_frontend/features/login/bloc/login_bloc.dart';
import 'package:ecommerce_frontend/features/onbording/bloc/onbording_bloc.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_bloc.dart';
// import 'package:ecommerce_frontend/features/shope/view/address/Widgets/pick_location_page.dart';
import 'package:ecommerce_frontend/features/signup/view/verify_email_page.dart';
import 'package:ecommerce_frontend/features/splash/view/splass_screen.dart';
import 'package:ecommerce_frontend/firebase_options.dart';
import 'package:firebase_authentication/firebase_authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(AuthenticationRepository());

  final productService = ProductService();
  final userService = UserService();

  runApp(App(productService: productService, userService: userService));
}

class App extends StatelessWidget {
  final ProductService productService;
  final UserService userService;

  const App({
    super.key,
    required this.productService,
    required this.userService,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnbordingBloc>(create: (_) => OnbordingBloc()),
        BlocProvider<LoginBloc>(create: (_) => LoginBloc()),
        BlocProvider<ShopeBloc>(
          create: (_) => ShopeBloc(productService, userService),
        ),
      ],
      child: ToastificationWrapper(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter node ecommerce app',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          routes: {"/verify-email": (context) => VerifyEmailPage()},
          home: const SplashScreen(), // 👈 First screen
        ),
      ),
    );
  }
}
//    tibebe@gmail.com             @F1212

// melkuna asamro ende welo feres 5 kifl new eskezare dress
// medlote tsdk kits =2 ,wedeladite amlak  , masiyas , gubayate betekrsityan ,ahati dngl ..... @nuhamin_yz4
//ortodox =.....yeabue shinoda metshaf,  https://www.tiktok.com/@hana21.29/video/7699879344621096193?is_from_webapp=1&sender_device=pc
