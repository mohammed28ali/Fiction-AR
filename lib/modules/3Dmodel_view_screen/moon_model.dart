import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../home_screen.dart';
class MoonModel extends StatefulWidget {
  const MoonModel({Key? key}) : super(key: key);

  @override
  State<MoonModel> createState() => _MoonModelState();
}

class _MoonModelState extends State<MoonModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()));
          },
          icon: const Icon(Icons.arrow_back_ios,
            color: Colors.black,),
        ),
      ),
      body: ModelViewer(
        src: 'assets/3DModel/moon.glb',
        alt: "A 3D model of an astronaut",
        ar: true,
        backgroundColor: Colors.transparent,
        autoPlay: true,
        autoRotate: true,
        cameraControls: true,
      ),
    );
  }
}
