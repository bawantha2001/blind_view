import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {

  final MobileScannerController _mobileScannerControllercontroller = MobileScannerController();

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
          MobileScanner(
            controller: _mobileScannerControllercontroller,
            onDetect: (result){
              print(result.barcodes.first.rawValue);
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
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
            ),
          ),
        ],
      ),
    );
  }
}
