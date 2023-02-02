import 'package:fiction_ar/modules/3Dmodel_view_screen/moon_model.dart';
import 'package:fiction_ar/modules/3Dmodel_view_screen/town_model.dart';
import 'package:fiction_ar/modules/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:toast/toast.dart';

const languages =
[
  Language('English', 'en_US'),
];

class Language
{
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class VoiceSearchScreen extends StatefulWidget {
  const VoiceSearchScreen({Key? key}) : super(key: key);

  @override
  State<VoiceSearchScreen> createState() => _VoiceSearchScreenState();
}

class _VoiceSearchScreenState extends State<VoiceSearchScreen>
{
  late SpeechRecognition _speech;
  bool _speechRecognitionAvailable = false;
  bool _isListening = false;
  String _voiceListeningWord = ''.toLowerCase();
  Language selectedLang = languages.first;

  @override
  initState() {
    super.initState();
    activateSpeechRecognizer();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void activateSpeechRecognizer() {
    _speech = SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech.setErrorHandler(errorHandler);
    _speech.activate('fr_FR').then((res) {
      setState(() => _speechRecognitionAvailable = res);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor:const Color.fromRGBO(24, 52, 101, 10) ,
          title: const Text('Speech Recognition'),
          leading: IconButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()));
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.grey.shade200,
                          child: Center(
                            child: TextButton(
                              onPressed: (){
                                if(_voiceListeningWord.toLowerCase()=="moon") {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (
                                          _) => const MoonModel()));
                                }else if(_voiceListeningWord=="building"){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (
                                          _) => const TownModel()));
                                }else
                                {
                                  Toast.show("Sorry! Model not found",
                                      duration: Toast.lengthShort,
                                      gravity:  Toast.bottom);
                                }
                              },
                              child: Text(
                                _voiceListeningWord.toLowerCase(),
                                style: const TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      )
                  ),
                  _buildVoiceButton(
                    onPressed: _speechRecognitionAvailable && !_isListening
                        ? () => start() :() => cancel(),
                    label: _isListening
                        ? 'Listening...'
                        : 'Listen',
                  ),
                ],
              ),
            )),
      ),
    );
  }
  Widget _buildVoiceButton({required String label, VoidCallback? onPressed}) => Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color.fromRGBO(24, 52, 101, 10), // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ));

  //start listing function
  void start() => _speech.activate(selectedLang.code).then((_) {
    return _speech.listen().then((result) {
      setState(() {
        _isListening = result;
      });
    });
  });
  //cancel listing function
  void cancel() =>
      _speech.cancel().then((_) => setState(() => _isListening = false));
  //stop listing function
  void stop() =>
      _speech.stop().then((_) {setState(() => _isListening = false);
      });

  void onSpeechAvailability(bool voiceResult) =>
      setState(() => _speechRecognitionAvailable = voiceResult);

  void onCurrentLocale(String locale) {
    setState(() => selectedLang = languages.firstWhere((l) => l.code == locale));
  }

  void onRecognitionStarted() {
    setState(() => _isListening = true);
  }

  void onRecognitionResult(String text) {
    setState(() => _voiceListeningWord = text);
  }

  void onRecognitionComplete(String text) {
    setState(() => _isListening = false);
  }
  void errorHandler() => activateSpeechRecognizer();
}
