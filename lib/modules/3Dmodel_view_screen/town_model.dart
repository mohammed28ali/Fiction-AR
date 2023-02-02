import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../home_screen.dart';
class TownModel extends StatefulWidget {
  const TownModel({Key? key}) : super(key: key);

  @override
  State<TownModel> createState() => _TownModelState();
}

class _TownModelState extends State<TownModel> {
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
        src: 'assets/3DModel/city.glb',
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
