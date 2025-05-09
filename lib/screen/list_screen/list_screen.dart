import 'package:blind_view/providers/shopping_provider.dart';
import 'package:blind_view/screen/list_screen/widgets/products_screen.dart';
import 'package:blind_view/services/voice_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';
import 'package:voice_to_text/voice_to_text.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final VoiceToText _voiceToText = VoiceToText();
  String catName = "";

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
        setState(() {
          catName = _voiceToText.speechResult;
        });

        print(_voiceToText.speechResult);
        Provider.of<ShoppingProvider>(context,listen: false).categoryName.forEach((element){
          if(element.toLowerCase()==catName.toLowerCase()){
            VoiceService().speak("Showing $catName");
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsScreen(catergory: element),));
          }
        });
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
            Text("Shopping Categories",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w800)),
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
                        hintText: "Search Categories..."
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Consumer<ShoppingProvider>(builder: (context, shopping, child) {
                        return  shopping.categoryName.isNotEmpty && !shopping.isLoading?ListView.builder(
                          itemCount: shopping.categoryName.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: GestureDetector(
                                onTap: () {
                                  VoiceService().speak(shopping.categoryName.elementAt(index));
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsScreen(catergory: shopping.categoryName.elementAt(index)),));
                                },
                                child: Container(
                                  height: 90,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.4),blurRadius: 1,offset: Offset(-4, 4))],
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                          child: Image.asset("assets/images/test.jpg",fit: BoxFit.fill,),
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft:Radius.circular(10) ),
                                      ),
                                      SizedBox(width: 10,),
                                      Text("${shopping.categoryName.elementAt(index)}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.input_rounded,color: Colors.blue,),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                        },
                        ):Column(
                          children: [
                            Image.asset("assets/images/no_item.png",width: 250,height: 250,),
                          ],
                        );
                      }
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
