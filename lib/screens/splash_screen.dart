import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesimpsons/constants/color_constants.dart';
import 'package:thesimpsons/constants/text_constants.dart';
import 'package:thesimpsons/screens/login_page.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSplashScreen(
          splashIconSize: 400,
          splash: Lottie.asset(TextConstants.lottie,
              alignment: Alignment.center),
          duration: 5000,
          backgroundColor: ColorConstants.black,
          nextScreen: const LoginPage(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
        ),
      ),
    );
  }
}
