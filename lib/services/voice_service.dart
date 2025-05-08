import 'package:flutter_tts/flutter_tts.dart';

class VoiceService{
  FlutterTts flutterTts = FlutterTts();

  Future speak(String word) async{
    await flutterTts.speak(word);
  }

}