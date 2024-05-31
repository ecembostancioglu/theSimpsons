import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesimpsons/screens/login_page.dart';

import '../constants/constants.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSplashScreen(
          splashIconSize: 400,
          splash: Lottie.asset(lottie,
              alignment: Alignment.center),
          duration: 5000,
          backgroundColor: Colors.black,
          nextScreen: const LoginPage(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
        ),
      ),
    );
  }
}
