import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../home_screen.dart';

class ModelView3D extends StatefulWidget {
  const ModelView3D({Key? key}) : super(key: key);

  @override
  State<ModelView3D> createState() => _ModelView3DState();
}

class _ModelView3DState extends State<ModelView3D> {
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
        src: 'assets/3DModel/tower.glb',
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
