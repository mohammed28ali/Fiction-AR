import 'package:concentric_transition/page_view.dart';
import 'package:fiction_ar/modules/home_screen.dart';
import 'package:fiction_ar/modules/onBording_screens/card_planet_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class OnBoardingScreen extends StatefulWidget {
    const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final data =
  [
    CardPlanetData(
        title: "Sample",
        subtitle:"Add new features to your world with augmented reality technology",
        image: const AssetImage("assets/images/ar.png"),
        backgroundColor: const Color.fromRGBO(0, 10, 56, 1),
        titleColor: Colors.pink,
        subtitleColor: Colors.white,
        background: LottieBuilder.asset("assets/animation/78255-background-looping-animation.json")
    ),
    CardPlanetData(
      title: "Creative",
      subtitle: "recognize words and sound to develop your reality",
      image: const AssetImage("assets/images/man2.png"),
      backgroundColor: Colors.white,
      titleColor: Colors.purple,
      subtitleColor:const Color.fromRGBO(0, 10, 56, 1),
        background: LottieBuilder.asset("assets/animation/78255-background-looping-animation.json")

    ),
    CardPlanetData(
      title: "        Start UP",
      subtitle: "       add some intelligence and interaction",
      image: const AssetImage("assets/images/hand.png"),
      backgroundColor: const Color.fromRGBO(71, 59, 117, 1),
      titleColor: Colors.yellow,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animation/78255-background-looping-animation.json"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const HomeScreen()));
        },
        backgroundColor: const Color.fromRGBO(24, 52, 101, 10),
        child: const Icon(Icons.arrow_forward_ios,
        color:Colors.white),
      ),
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount:data.length ,
        itemBuilder: (int index, double value) {
          return CardPlanet(data: data[index]);
        },
      ),
    );
  }
}
