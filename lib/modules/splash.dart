import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fiction_ar/modules/onBording_screens/onBording_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 35.0),
            child: Image.asset("assets/images/logo.png",
              height: 620,
              width: 600,
              fit: BoxFit.cover,
            ),
          ),
          const Text('VISION MORE ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor:const Color.fromRGBO(24, 52, 101, 10),
      nextScreen: const OnBoardingScreen(),
      splashIconSize: 2000,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      animationDuration:const Duration(seconds:1 ) ,
    );
  }
}
