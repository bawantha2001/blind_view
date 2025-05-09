import 'package:blind_view/providers/shopping_provider.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../../../services/voice_service.dart';
class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {

  final MobileScannerController _mobileScannerControllercontroller = MobileScannerController();

  bool isScanning = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mobileScannerControllercontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer<ShoppingProvider>(
            builder: (BuildContext context,shopping, Widget? child) {
              return MobileScanner(
                controller: _mobileScannerControllercontroller,
                onDetect: (result){
                  String id = result.barcodes.first.rawValue.toString();
                  shopping.items.forEach((element) {
                    if(element.itemCode == id){
                      _mobileScannerControllercontroller.stop().then((onValue){
                        setState(() {
                          isScanning = false;
                        });
                        Provider.of<ShoppingProvider>(context,listen: false).addItemToCart(element, 1);
                        VoiceService().speak("${element.itemName} added to the Cart");
                      });

                    }
                  },);

                },
              );
            },
          ),
          Align(
            alignment: Alignment.center,
            child: isScanning?Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  height: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2,color: Colors.blue),
                      color: Colors.transparent
                  ),
                ),
                SizedBox(height: 10,),
                Text("Position the barcode within the frame",style: TextStyle(color: Colors.white,fontSize: 15),)
              ],
            ):Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/item_added_success.png",width: 250,height: 250,),
                SizedBox(height: 5,),
                GestureDetector(
                  onTap: (){
                    _mobileScannerControllercontroller.start().then((onValue){
                      setState(() {
                        isScanning = true;
                      });
                    });

                  },
                  child: Container(
                    width: 180,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(child: Text("Re Scan Products",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.white),)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
