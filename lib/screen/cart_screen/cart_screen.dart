import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

import '../shop_screen/mobileScanner_Screen/scanner_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}


class _CartScreenState extends State<CartScreen> {
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
  void initState() {
    // TODO: implement initState
    super.initState();
    shakeStarter();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    shakeDetector?.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text("Your Cart",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w800)),
            Spacer(),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ScannerScreen(),));
              },
                child: Icon(Icons.qr_code,size: 30,color: Colors.blue,))
          ],
        ),
      ),
      body: Container(
        color: Color.fromRGBO(248, 249, 250, 1),
        child: ListView(
          children: [
            Column(
              children: [

              ],
            )
          ],
        ),
      ),
    );
  }
}
