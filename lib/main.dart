import 'package:fiction_ar/modules/onBording_screens/onBording_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'modules/home_screen.dart';
import 'modules/splash.dart';

List<CameraDescription>? cameras;


Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  cameras =await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

