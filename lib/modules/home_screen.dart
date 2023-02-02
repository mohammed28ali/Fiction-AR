import 'package:fiction_ar/modules/3Dmodel_view_screen/3Dmodel_view_screen.dart';
import 'package:fiction_ar/modules/3Dmodel_view_screen/sun_mode.dart';
import 'package:fiction_ar/modules/about_screen.dart';
import 'package:fiction_ar/modules/object_detection_screen.dart';
import 'package:fiction_ar/modules/voice_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';
import 'package:toast/toast.dart';





class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //=>>>>>OCR parameters
  final int? _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  final bool _autoFocusOcr = true;
  final bool _torchOcr = false;
  final bool _multipleOcr = true;
  final bool _waitTapOcr = true;
  final bool _showTextOcr = true;
  Size? _previewOcr;
  String _textReadValue ='';


  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      extendBodyBehindAppBar:true ,
      appBar: AppBar(
        brightness:Brightness.dark ,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            //bottomRight: Radius.circular(-50),
          ),
        ),
        backgroundColor: const Color.fromRGBO(24, 52, 101, 10),
        elevation: 8.0,
        toolbarHeight: 110,
        title: Column(
          children:
          [
            const SizedBox(
              height: 20.0,
            ),
            Container(
              margin: const EdgeInsets.only(left: 35.0),
              alignment: Alignment.center,
              child: const Image(
                image: AssetImage('assets/images/logo.png'),
                height: 620,
                width: 600,
                fit: BoxFit.cover,
              ),
            ),

          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        // centerTitle: true,
      ),
      body:SpinCircleBottomBarHolder(
        bottomNavigationBar:SCBottomBarDetails(
          backgroundColor:const Color.fromRGBO(24, 52, 101, 10),
          titleStyle: const TextStyle(color: Colors.white,fontSize: 12),
          iconTheme: const IconThemeData(color: Colors.blueGrey,),
          activeIconTheme: const IconThemeData(color: Colors.white),
          actionButtonDetails: SCActionButtonDetails(
              color: Colors.blue,
              icon: const Icon(
                Icons.expand_less
              ),
              elevation: 2,
          ),
          elevation: 8.0,
          items:
          [
            SCBottomBarItem(icon: Icons.refresh_outlined, onPressed: ()
            {
              setState(() {
                _textReadValue="";
              });
            }),
            SCBottomBarItem(icon: Icons.info_outline, onPressed: ()
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AboutScreen()));
            }),
          ],
          circleItems:
          [
            SCItem(icon: const Icon(Icons.local_see_outlined) ,
              onPressed:(){
              Navigator.push(context,
                 MaterialPageRoute(builder: (_) => const ObjectDetectionScreen()));
               }),
            SCItem(icon: const Icon(Icons.title_outlined), onPressed: _read),
            SCItem(icon: const Icon(Icons.mic_outlined), onPressed:(){
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const VoiceSearchScreen()));
            }),
          ],
          bnbHeight: 80,
          circleColors:
          [
            Colors.amberAccent,
            Colors.amberAccent,
            Colors.amberAccent,
          ],
        ) ,
        child:ListView(
          children: <Widget>[
            const SizedBox(
              height: 230,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: TextButton(
                      onPressed: (){
                        if(_textReadValue.toLowerCase()=="tower") {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (
                                  _) => const ModelView3D()));
                        }else if(_textReadValue.toLowerCase()=="sun"){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (
                                  _) => const SunModel()));
                        }else
                        {
                          Toast.show("Sorry! Model not found",
                              duration: Toast.lengthShort,
                              gravity:  Toast.bottom);
                        }
                          },
                    child: Text(_textReadValue,
                      style: const TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }



//:::::::::::::::FUNCTIONS::::::::::::::://
  //OCR FUNCTION
  Future<void> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        flash: _torchOcr,
        autoFocus: _autoFocusOcr,
        multiple: _multipleOcr,
        waitTap: _waitTapOcr,
        forceCloseCameraOnTap: true,
        imagePath: '',
        showText: _showTextOcr,
        preview: _previewOcr ?? FlutterMobileVision.PREVIEW,
        camera: _cameraOcr ?? FlutterMobileVision.CAMERA_BACK,
        fps: 2.0,
      );
      setState(() {
        _textReadValue = texts[0].value;
      });
    } on Exception {
      texts.add(OcrText('Failed to recognize text.'));
    }
  }
}



