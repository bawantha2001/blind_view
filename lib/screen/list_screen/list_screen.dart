import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:voice_to_text/voice_to_text.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final VoiceToText _voiceToText = VoiceToText();

  void initVoicetoText(){
    _voiceToText.initSpeech();
    _voiceToText.addListener(() {
      if(_voiceToText.isListening){
        showListening();
      }else{
        try{
          Navigator.pop(context);
        }catch(e){

        }
        print(_voiceToText.speechResult);
      }
    },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback){
      initVoicetoText();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text("Shopping Lists",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w800)),
            Spacer(),
            Icon(Icons.star_border_outlined,size: 30,color: Colors.blue,)
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: (){
          if(_voiceToText.isNotListening){
            _voiceToText.startListening();
          }else{
            _voiceToText.stop();
          }
        },
        child: Container(
          height: 60,
          width: 60,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: Colors.blue
          ),
          child: Icon(Icons.mic_none_rounded,color: Colors.white,),
        ),
      ),
      body: SafeArea(
          child: ListView(
            children: [
              Container(
                color: Color.fromRGBO(248, 249, 250, 1),
                padding: EdgeInsets.symmetric(horizontal:20,vertical: 15),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent,width: 0),borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent,width: 0),borderRadius: BorderRadius.circular(15)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent,width: 0),borderRadius: BorderRadius.circular(15)),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent,width: 0),borderRadius: BorderRadius.circular(15)),
                        fillColor: Colors.grey.withOpacity(0.2),
                        filled: true,
                        prefixIcon: Icon(Icons.search,color: Colors.grey,),
                        hintText: "Search lists..."
                      ),
                    )
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
  void showListening(){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 100,
                width: 105,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset("assets/images/voice.gif")
            ),
          ],
        );
      },
    );
  }
}
