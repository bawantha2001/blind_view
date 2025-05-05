import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  ShakeDetector? shakeDetector;


  void shakeStarter(){
    shakeDetector?.stopListening();

    shakeDetector = ShakeDetector.autoStart(
        onPhoneShake: (event) {
          switch (event.direction){
            case ShakeDirection.x:
              print("left right detected");
              break;
            case ShakeDirection.y:
              print("left right detected");
              break;
            case ShakeDirection.z:
              print("left right detected");
              break;
            case ShakeDirection.undefined:
              print("left right detected");
              break;
          }
        },
        useFilter: false,
        shakeThresholdGravity: 1.1
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    shakeDetector?.stopListening();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback){
      shakeStarter();
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

        },
        child: Container(
          height: 60,
          width: 60,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: Colors.blue
          ),
          child: Icon(Icons.add,color: Colors.white,),
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
}
