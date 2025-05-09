import 'package:blind_view/providers/shopping_provider.dart';
import 'package:blind_view/services/voice_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_to_text/voice_to_text.dart';

class ProductsScreen extends StatefulWidget {
  final String catergory;
  const ProductsScreen({super.key,required this.catergory});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

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
        Provider.of<ShoppingProvider>(context,listen: false).categorizedItems[widget.catergory]!.forEach((element) {
          if(element.itemName!.toLowerCase() == catName.toLowerCase()){
            VoiceService().speak("${element.itemName} added to the cart");
            Provider.of<ShoppingProvider>(context,listen: false).addItemToCart(element, 1);
          }
        },
        );
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("${widget.catergory}",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w800)),
      ),
      body: Container(
        color: Color.fromRGBO(248, 249, 250, 1),
        padding: EdgeInsets.symmetric(horizontal:20,vertical: 15),
        child: Consumer<ShoppingProvider>(builder: (context, shopping, child) {
          return GridView.builder(itemCount: shopping.categorizedItems[widget.catergory]?.length??0,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),
            itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                VoiceService().speak("${shopping.categorizedItems[widget.catergory]!.elementAt(index).itemName} added to the Cart");
                Provider.of<ShoppingProvider>(context,listen: false).addItemToCart(shopping.categorizedItems[widget.catergory]!.elementAt(index), 1);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withOpacity(0.4),blurRadius: 1,offset: Offset(-4, 4)),
                    ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(child:
                    ClipRRect(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                        child: Image.asset("assets/images/test.jpg",fit: BoxFit.cover))),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text("${shopping.categorizedItems[widget.catergory]!.elementAt(index).itemName}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                              Text("Rs.${shopping.categorizedItems[widget.catergory]!.elementAt(index).itemPrice}",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500),),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                          Spacer(),
                          Text("${shopping.categorizedItems[widget.catergory]!.elementAt(index).itemQuantity}",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w800),),
                          Icon(Icons.add_shopping_cart_rounded)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },);
        },),
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
