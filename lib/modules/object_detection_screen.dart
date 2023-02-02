import 'package:camera/camera.dart';
import 'package:fiction_ar/main.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:toast/toast.dart';

import '3Dmodel_view_screen/moon_model.dart';


class ObjectDetectionScreen extends StatefulWidget {
  const ObjectDetectionScreen({Key? key}) : super(key: key);

  @override
  State<ObjectDetectionScreen> createState() => _ObjectDetectionScreenState();
}

class _ObjectDetectionScreenState extends State<ObjectDetectionScreen>
{
  bool isWorking =false;
  String result="";
  String confidenceResult="";
  CameraController? cameraController;
  CameraImage? imgCamera;
  loadModel()async
  {
    await Tflite.loadModel(
      model:"assets/ml/mobilenet_v1_1.0_224.tflite",
      labels:"assets/ml/mobilenet_v1_1.0_224.txt",
    );
  }
  initCamera()
  {
    cameraController=CameraController(cameras![0],ResolutionPreset.medium);
    cameraController?.initialize().then((value)
    {
      if(!mounted)
      {
        return;
      }
      setState(() {
        cameraController?.startImageStream((imageFromStream) =>
        {
          if(!isWorking)
            {
              isWorking=true,
              imgCamera=imageFromStream,
              runModelOnStreamFrames(),
            }
        });
      });
    });
  }
  runModelOnStreamFrames()async
  {
    if(imgCamera!=null)
    {
      var recognition =await Tflite.runModelOnFrame(
        bytesList:imgCamera!.planes.map((plane)
        {
          return plane.bytes;
        }).toList(),
        imageHeight: imgCamera!.height,
        imageWidth: imgCamera!.width,
        imageMean:127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 1,
        threshold: 0.1,
        asynch: true,
      );
      result="";
      confidenceResult="";
      recognition?.forEach((response)
      {
        //+"  "+(response["confidence"]as double).toStringAsFixed(2)
        result +=response["label"]+"\n";
        confidenceResult +=(response["confidence"]as double ).toStringAsFixed(2)+"\n\n";
      });
      setState(() {
        result;
        confidenceResult;
      });
      isWorking=false;
    }
  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  void dispose()async {
    super.dispose();
    await Tflite.close();
    cameraController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child:Scaffold(
          body: Container(
            child: Column(
              children:
              [
                Stack(
                  children:
                  [
                    Center(
                      child: Container(
                        color: Colors.black,
                        height: 320,
                        width: 360,
                      ),
                    ),
                    Center(
                      child: MaterialButton(
                        onPressed: ()
                        {
                          initCamera();
                        },
                        child: Container(
                          margin:const EdgeInsets.only(top: 35),
                          height: 270,
                          width: 355,
                          child: imgCamera==null?Container(
                            height: 270,
                            width: 355,
                            child: const Icon(Icons.camera_alt_outlined,color: Colors.white,size: 40,),
                          ):AspectRatio(
                            aspectRatio: cameraController!.value.aspectRatio,
                            child: CameraPreview(cameraController!),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top:55.0),
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (
                                      _) => const MoonModel()));
                            
                          },
                          child: Text(
                            result.toLowerCase(),
                            style: const TextStyle(
                              fontSize: 40.0,
                              color: Colors.transparent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          result ="earth",
                          style: const TextStyle(
                            fontSize: 30.0,
                            color: Colors.transparent,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                         confidenceResult,
                          style: const TextStyle(
                            fontSize: 30.0,
                            color: Colors.transparent,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ) ,
      ),
    );
  }
}